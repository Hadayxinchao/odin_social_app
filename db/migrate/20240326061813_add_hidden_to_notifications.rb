class AddHiddenToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :hidden, :boolean, null: false, default: false
  end
end
