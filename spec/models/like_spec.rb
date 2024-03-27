require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:likeable) }
    it { should have_many(:notifications).dependent(:destroy) }
  end
end
