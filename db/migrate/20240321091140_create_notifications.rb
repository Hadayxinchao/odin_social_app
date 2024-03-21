class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :notificationable, polymorphic: true, null: false
      
      t.timestamps
    end
  end
end
