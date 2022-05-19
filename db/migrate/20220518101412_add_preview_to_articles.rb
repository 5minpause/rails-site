class AddPreviewToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :draft, :boolean, default: true
    add_index :articles, :draft
  end
end
