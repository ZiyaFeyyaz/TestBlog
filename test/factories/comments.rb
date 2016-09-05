FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph 1, true, 3 }
  end
end
