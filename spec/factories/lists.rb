FactoryGirl.define do
  factory :list do
    sequence(:name) { |n| "List #{n}" }
    active true
    association :user
  end
end

