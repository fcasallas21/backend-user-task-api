require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { User.create!(email: "angelao@example.com", full_name: "Angela Oliveros", role: "admin") }

  describe "GET /api/v1/users" do
    it "returns all users" do
      get "/api/v1/users"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to be >= 1
    end
  end

  describe "GET /api/v1/users/:id" do
    it "returns a user with a specific id" do
      get "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(user.id)
    end
  end
end