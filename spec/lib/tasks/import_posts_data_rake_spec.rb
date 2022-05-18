# frozen_string_literal: true

require "rails_helper"
require "support/shared_contexts_rake"

RSpec.describe "import_posts_data" do # rubocop:disable RSpec/DescribeClass
  include_context "with rake"

  let(:import_path) do
    "spec/fixtures"
  end

  it "creates two articles" do
    expect do
      task.invoke(import_path)
    end.to change(Article, :count).by(2)
  end

  describe "title" do
    before { task.invoke(import_path) }

    it { expect(Article.first.title).to eq("Answering a comment about 'Delete all your tests'") }
    it { expect(Article.second.title).to eq("A neverending story") }
  end

  describe "published_at" do
    before { task.invoke(import_path) }

    it { expect(Article.first.published_at.strftime("%Y-%m-%d %H:%M:%S %z")).to eq("2019-02-20 14:24:00 +0000") }
    it { expect(Article.second.published_at.strftime("%Y-%m-%d %H:%M:%S %z")).to eq("2019-02-27 14:24:00 +0000") }
  end

  describe "content" do
    before { task.invoke(import_path) }

    it { expect(Article.first.content).to start_with("\n\nMatthias Berth is a German expert") }
    it { expect(Article.second.content).to start_with("\nBack then;\nI did it;\nI liked it much;") }
  end

  describe "categories" do
    before { task.invoke(import_path) }

    it { expect(Category.where(name: "article")).to exist }
    it { expect(Category.where(name: "code review")).to exist }
    it { expect(Category.where(name: "quality")).to exist }
  end

  it "connects articles to categories" do
    task.invoke(import_path)

    expect(Article.first.categories.map(&:name)).to eq(["article", "code review", "quality"])
  end
end
