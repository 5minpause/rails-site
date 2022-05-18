# frozen_string_literal: true

# A custom renderer that displays the whole article
class FullRenderer < Redcarpet::Render::HTML
  def preprocess(full_document)
    full_document.gsub!(/([\s\S]*)(<!--more-->)([\s\S]*)/) do
      "#{Regexp.last_match(1)} #{Regexp.last_match(3)}"
    end
    full_document
  end
end
