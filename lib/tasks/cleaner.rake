namespace :cleaner do
  desc "Reset database"
  task all: "db:reset" do
    puts "The database reseted."
  end

  desc "Delete old articles"
  task articles: :environment do
    Category.all.each do |category|
      articles_count = category.articles.size
      if articles_count > 5
        category.articles.each do |article|
          article.destroy
          articles_count -= 1
          break if articles_count == 5
        end
      end
    end

    puts "The old articles deleted."
  end
end
