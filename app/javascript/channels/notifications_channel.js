import consumer from "channels/consumer"

const notificationsChannel = consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const html = `${data['html']}`;
    const h2 = document.querySelector('.notifications > h2');
    h2.insertAdjacentHTML('afterend', html);
    const notifications = document.querySelector('.notifications');
    const symbol = document.querySelector('.notification-symbol');
    if (notifications.classList.contains('show')) {
      updateTimestamp();    
    } else {
      symbol.textContent = 'Notifications Unread';
      symbol.classList.add('notifications-unread');
    }
  },
});

function updateTimestamp() {
  notificationsChannel.send({data: 'data'})
}