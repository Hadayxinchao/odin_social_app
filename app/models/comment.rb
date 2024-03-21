class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :notifications, as: :notificationable, dependent: :destroy
  validates :content, presence: true
end
