module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def handle_open
      @protocol = websocket.protocol
      connect if respond_to?(:connect)
      subscribe_to_internal_channel
      send_welcome_message

      message_buffer.process!
      server.add_connection(self)
    rescue ActionCable::Connection::Authorization::UnauthorizedError
      close(reason: ActionCable::INTERNAL[:disconnect_reasons][:unauthorized], reconnect: true) if websocket.alive?
    end

    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
