require 'rails_helper'

RSpec.describe "Api::V1::Tasks", type: :request do

  before do
    allow_any_instance_of(ApplicationController).to receive(:authorize_request).and_return(true)
  end
  
  let!(:user) { User.create!(email: "angelao@example.com", full_name: "Angela Oliveros", role: "admin") }
  let!(:task) { Task.create!(title: "task_testing", status: "pending", user: user) }

  describe "GET /api/v1/tasks" do
    it "returns all tasks" do
      get "/api/v1/tasks"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to be >= 1
    end
  end

  describe "GET /api/v1/tasks/:id" do
    it "returns a task with a specific id" do
      get "/api/v1/tasks/#{task.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(task.id)
    end
  end

  describe "POST /api/v1/tasks" do
    it "creates a task" do
      post "/api/v1/tasks", params: {
        task: {
          title: "New Task",
          status: "pending",
          user_id: user.id
        }
      }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["title"]).to eq("New Task")
    end
  end

  describe "PATCH /api/v1/tasks/:id" do
    it "updates a task" do
      patch "/api/v1/tasks/#{task.id}", params: {
        task: { title: "Updated Title" }
      }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["title"]).to eq("Updated Title")
    end
  end

  describe "DELETE /api/v1/tasks/:id" do
    it "deletes a task" do
      delete "/api/v1/tasks/#{task.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("REGISTRO ELIMINADO CORRECTAMENTE")
    end
  end
end