require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe "methods" do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let(:friendship) { create(:friendship, user: user, friend: friend) }

    it "creates a mirror friendship" do
      expect {
        friendship.create_mirror_friendship
      }.to change(Friendship, :count).by(2)

      mirror_friendship = Friendship.last
      expect(mirror_friendship.user_id).to eq(friend.id)
      expect(mirror_friendship.friend_id).to eq(user.id)
      expect(mirror_friendship.status).to eq(1)
    end
  end
end
