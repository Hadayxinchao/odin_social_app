require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(email: "john@example.com", password: "password")
      expect(user).to be_valid
    end

    it "is not valid without a email" do
      user = User.new(password: "password")
      expect(user).not_to be_valid
    end
  end

  describe "associations" do
    it "has many posts" do
      user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
      expect(user.posts).to be_empty

      post = user.posts.build(content: "Hello, world!")
      expect(user.posts).to include(post)
    end
  end
end
