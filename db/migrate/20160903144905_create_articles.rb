class CreateArticles < ActiveRecord::Migration[5.0]
  def up
    create_table :articles do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
 
  def down
    drop_table :articles
  end
end
