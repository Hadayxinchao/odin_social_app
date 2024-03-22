class AddPathToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :path, :string
  end
end
