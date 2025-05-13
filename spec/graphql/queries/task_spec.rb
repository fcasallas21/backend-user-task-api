require 'rails_helper'

RSpec.describe 'GraphQL - Tasks Query', type: :request do
  let(:user) { User.create!(email: "abgelao@test.com", full_name: "Angela Oliveros", role: "admin") }
  let!(:task) { Task.create!(title: "testing_task", status: "pending", user: user) }

  let(:query) do
    <<~GQL
      query {
        tasks {
          id
          title
          status
        }
      }
    GQL
  end

  it "returns tasks with the detail of attributets" do
    post "/graphql", params: { query: query }
    json = JSON.parse(response.body)
    expect(json["data"]["tasks"]).to be_an(Array)
    expect(json["data"]["tasks"].first["title"]).to eq("testing_task")
  end
end