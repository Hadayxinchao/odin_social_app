class AddStatusToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :status, :integer
  end
end
