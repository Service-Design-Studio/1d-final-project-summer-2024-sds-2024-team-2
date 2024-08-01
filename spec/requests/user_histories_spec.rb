require 'rails_helper'

RSpec.describe "UserHistories", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/user_histories/create"
      expect(response).to have_http_status(:success)
    end
  end

end
