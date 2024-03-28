require 'rails_helper'

RSpec.describe "Landings", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/landings/home"
      expect(response).to have_http_status(:success)
    end
  end

end
