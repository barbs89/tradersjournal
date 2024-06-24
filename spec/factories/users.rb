FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password_digest { "MyString123" }
  end
end
