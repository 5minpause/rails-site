class Article < ApplicationRecord
  before_save :set_slug
  validates_uniqueness_of :slug
  validates_uniqueness_of :title

  private

  def set_slug
    self.slug = self.title.parameterize
  end
end
