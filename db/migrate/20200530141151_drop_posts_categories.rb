class DropPostsCategories < ActiveRecord::Migration[6.0]
  def change
    drop_table :posts_categories
  end
end
