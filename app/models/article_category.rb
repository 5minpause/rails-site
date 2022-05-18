# frozen_string_literal: true

# == Schema Information
#
# Table name: article_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  article_id  :bigint
#  category_id :bigint
#
# Indexes
#
#  index_article_categories_on_article_id   (article_id)
#  index_article_categories_on_category_id  (category_id)
#
class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
end
