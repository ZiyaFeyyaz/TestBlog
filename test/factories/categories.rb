FactoryGirl.define do
  factory :category do
    name { Faker::Superhero.power }

    factory :category_with_articles do
      transient do
        articles_count Random.rand(1..10)
      end

      after(:create) do |category, evaluator|
        create_list(:article_with_comments, evaluator.articles_count, category: category)
      end
    end
  end
end
