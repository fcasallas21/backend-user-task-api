require 'rails_helper'

RSpec.describe User, type: :model do
  #let(:user) { User.create!(email: "test@hotmail.com", full_name: "Test", role: "user") }
  
  it "Valid with valid attributes (USER)" do
    user = User.new(email: "test@hotmail.com", full_name: "Test", role: "user")
    expect(user).to be_valid
  end

  it "Invalid without a role" do
    user = User.new(email: "test@hotmail.com", full_name: "Test")
    expect(user).not_to be_valid
  end

end