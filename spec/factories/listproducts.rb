FactoryGirl.define do
  factory :listproduct, class: Listproduct do
    sequence(:skuid) { |n| "404+#{n}" }
    association :list
  end
end