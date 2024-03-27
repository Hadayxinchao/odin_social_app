require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:notificationable) }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end
end
