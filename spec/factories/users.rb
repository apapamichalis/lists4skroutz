FactoryGirl.define do
  factory :user do
    name              "Test User" 
    sequence(:email)  { |n| "test#{n}@example.com" }
    password          "secure-password"
  end
end
