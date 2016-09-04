FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph 10 }

    factory :article_with_comments do
      transient do
        comments_count 2
      end

      after(:create) do |article, evaluator|
        create_list(:comment, evaluator.comments_count, article: article)
      end
    end
  end
end
