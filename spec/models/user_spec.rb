require 'rails_helper'

RSpec.describe User, type: :model do
  it "can be created" do
    user = FactoryBot.create(:user)
    expect(user).to be_persisted
  end

  it "can be read" do
    user = FactoryBot.create(:user)
    found_user = User.find(user.id)
    expect(found_user).to eq(user)
  end

  it "can be destroyed" do
    user = FactoryBot.create(:user)
    user.destroy
    expect(User.exists?(user.id)).to be_falsey
  end
end
