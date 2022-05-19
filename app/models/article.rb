# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  content      :text
#  draft        :boolean          default(TRUE)
#  published_at :datetime
#  slug         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_articles_on_draft  (draft)
#  index_articles_on_slug   (slug) UNIQUE
#  index_articles_on_title  (title) UNIQUE
#
class Article < ApplicationRecord
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many_attached :images

  before_save :set_slug
  validates :slug, uniqueness: true
  validates :title, uniqueness: true

  scope :published, -> { where(draft: false) }

  private

  def set_slug
    return unless title

    self.slug = title.parameterize
  end
end
