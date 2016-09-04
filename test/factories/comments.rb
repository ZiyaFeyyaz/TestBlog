FactoryGirl.define do
  factory :comment do
    commenter { Faker::Name.first_name }
    body { Faker::Lorem.paragraph 1, true, 3 }
  end
end
