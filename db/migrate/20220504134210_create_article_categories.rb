class CreateArticleCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :article_categories do |t|
      t.bigint :article_id
      t.bigint :category_id

      t.timestamps
    end
    add_index :article_categories, :article_id
    add_index :article_categories, :category_id
  end
end
