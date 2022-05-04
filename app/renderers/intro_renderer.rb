# frozen_string_literal: true

class IntroRenderer < Redcarpet::Render::HTML
  def preprocess(full_document)
    full_document.gsub! /([\s\S]*)(<!--more-->)([\s\S]*)/ do
      "#{$1}"
    end
    full_document
  end
end