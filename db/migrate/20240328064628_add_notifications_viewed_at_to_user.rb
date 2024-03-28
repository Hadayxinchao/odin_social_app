class AddNotificationsViewedAtToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :notifications_viewed_at, :datetime
  end
end
