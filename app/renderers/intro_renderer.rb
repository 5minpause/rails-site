# frozen_string_literal: true

# A custom renderer for showing only the intros of articles
class IntroRenderer < Redcarpet::Render::HTML
  def preprocess(full_document)
    full_document.gsub!(/([\s\S]*)(<!--more-->)([\s\S]*)/) do
      Regexp.last_match(1).to_s
    end
    full_document
  end
end
