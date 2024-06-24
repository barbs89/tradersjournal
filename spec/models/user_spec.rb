# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "can be created with valid attributes" do
    user = FactoryBot.create(:user)
    expect(user).to be_persisted
  end

  it "can be read" do
    user = FactoryBot.create(:user)
    found_user = User.find(user.id)
    expect(found_user).to eq(user)
  end

  it "cannot update the email address" do
    user = FactoryBot.create(:user)
    original_email = user.email
    user.update(email: "new_email@example.com")
    expect(user.reload.email).to eq(original_email)
    expect(user.errors[:email]).to include("cannot be updated")
  end

  it "can be destroyed" do
    user = FactoryBot.create(:user)
    user.destroy
    expect(User.exists?(user.id)).to be_falsey
  end

  it "authenticates with valid password" do
    user = FactoryBot.create(:user, password: "password123", password_confirmation: "password123")
    authenticated_user = User.find_by(email: user.email).authenticate("password123")
    expect(authenticated_user).to eq(user)
  end

  it "does not authenticate with invalid password" do
    user = FactoryBot.create(:user, password: "password123", password_confirmation: "password123")
    authenticated_user = User.find_by(email: user.email).authenticate("wrongpassword")
    expect(authenticated_user).to be_falsey
  end
end
