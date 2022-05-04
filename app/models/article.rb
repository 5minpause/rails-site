class Article < ApplicationRecord
  has_many :article_categories
  has_many :categories, through: :article_categories

  before_save :set_slug
  validates_uniqueness_of :slug
  validates_uniqueness_of :title

  private

  def set_slug
    return unless self.title

    self.slug = self.title.parameterize
  end
end
