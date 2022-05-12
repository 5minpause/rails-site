# frozen_string_literal: true

require "article_parser"

desc "Import posts data from Gatsby posts folder"
task :import_posts_data, [:posts_data] => :environment do |_t, args|
  posts_data_file_path = args.fetch(:posts_data)

  working_directory = Dir.new(posts_data_file_path)
  working_directory.children.each do |child_path|
    next if [".DS_Store", "..", "."].include?(child_path)

    path = [working_directory.path, child_path].join("/")
    parser = ArticleParser.new(path)

    article = Article.where(
      title: parser.title
    ).first_or_create!(
      content: parser.body,
      published_at: parser.date,
      slug: parser.title.parameterize
    )

    parser.categories.each do |category_name|
      cat = Category.where(name: category_name).first_or_create!
      ArticleCategory.where(article_id: article.id, category_id: cat.id).first_or_create!
    end
  end
end
