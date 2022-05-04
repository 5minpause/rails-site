# frozen_string_literal: true

class FullRenderer < Redcarpet::Render::HTML
  def preprocess(full_document)
    full_document.gsub! /([\s\S]*)(<!--more-->)([\s\S]*)/ do
      "#{$1} #{$3}"
    end
    full_document
  end
end