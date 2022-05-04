# frozen_string_literal: true

class ArticleParser

  def initialize(path, filename = "index.md")
    @path = path
    @filename = filename
  end

  def markdown_doc
    File.read([path, filename].join("/"))
  end

  def title
    markdown_doc.scan(title_regex).flatten.last
  end

  def date
    markdown_doc.scan(date_regex).flatten.last
  end

  def body
    markdown_doc.scan(body_regex).flatten.last
  end

  def categories
    markdown_doc.scan(categories_regex)
      .flatten
      .last
      .split(",")
      .map { |i| i.downcase.strip }
  end

  private

  attr_reader :path, :filename

  def title_regex
    /(title: ")([\w\s\d'-,\.]*)\"/
  end

  def date_regex
    /(date: )([ \d\-:+]*)/
  end

  def body_regex
    /(\n---\n)([\w\W\d\D\s\S]*)/
  end

  def categories_regex
    /(categories: )([\w ,]*)/
  end
end
