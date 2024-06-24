FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "MyString123" }
    password_confirmation { "MyString123" }
  end
end