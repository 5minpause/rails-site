# frozen_string_literal: true

require "rails_helper"
require "support/shared_contexts_rake"

RSpec.describe "import_posts_data" do
  include_context "rake"

  let(:import_path) do
    "spec/fixtures"
  end

  it "creates two articles" do
    expect {
      subject.invoke(import_path)
    }.to change(Article, :count).by(2)
  end

  it "sets the correct titles for the Articles" do
    subject.invoke(import_path)

    expect(Article.first.title).to eq("Answering a comment about 'Delete all your tests'")
    expect(Article.second.title).to eq("A neverending story")
  end

  it "sets the correct published_at values" do
    subject.invoke(import_path)

    expect(Article.first.published_at.strftime("%Y-%m-%d %H:%M:%S %z")).to eq("2019-02-20 14:24:00 +0000")
    expect(Article.second.published_at.strftime("%Y-%m-%d %H:%M:%S %z")).to eq("2019-02-27 14:24:00 +0000")
  end

  it "sets the correct content values" do
    subject.invoke(import_path)

    expect(Article.first.content).to start_with("\n\nMatthias Berth is a German expert")
    expect(Article.second.content).to start_with("\nBack then;\nI did it;\nI liked it much;")
  end

  it "creates the correct categories" do
    subject.invoke(import_path)

    expect(Category.where(name: "article")).to exist
    expect(Category.where(name: "code review")).to exist
    expect(Category.where(name: "quality")).to exist
  end

  it "connects articles to categories" do
    subject.invoke(import_path)

    expect(Article.first.categories.map(&:name)).to eq(%w(article code\ review quality))
  end
end
