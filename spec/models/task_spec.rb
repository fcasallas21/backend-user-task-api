require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { User.create!(email: "test@hotmail.com", full_name: "Test", role: "user") }
  
  it "Valid with valid attributes (TASK)" do
    task = Task.new(title: "Tarea", status: "pending", user: user)
    expect(task).to be_valid
  end

  it "Invalid without a title (TASK)" do
    task = Task.new(status: "pending")
    expect(task).not_to be_valid
  end

  it "Invalid without a status (TASK)" do
    task = Task.new(title: "Tarea")
    expect(task).not_to be_valid
  end
end