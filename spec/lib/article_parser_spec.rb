# frozen_string_literal: true

require "rails_helper"
require "article_parser"

RSpec.describe ArticleParser do
  subject { described_class.new(path) }
  context "given a correct path" do
    describe "#title" do
      context "when path is first article" do
        let(:path) { "spec/fixtures/a-neverending-story" }

        it "is correct" do
          expect(subject.title).to eq("A neverending story")
        end
      end

      context "when path is second article" do
        let(:path) { "spec/fixtures/answering-a-comment-about-delete-all-your-tests" }

        it "is correct" do
          expect(subject.title).to eq("Answering a comment about 'Delete all your tests'")
        end
      end
    end

    describe "#date" do
      context "when path is first article" do
        let(:path) { "spec/fixtures/a-neverending-story" }

        it "is correct" do
          expect(subject.date).to eq("2019-02-27 16:24:00 +0200")
        end
      end

      context "when path is second article" do
        let(:path) { "spec/fixtures/answering-a-comment-about-delete-all-your-tests" }

        it "is correct" do
          expect(subject.date).to eq("2019-02-20 16:24:00 +0200")
        end
      end
    end

    describe "#body" do
      context "when path is first article" do
        let(:path) { "spec/fixtures/a-neverending-story" }

        it "is correct" do
          expect(subject.body).to start_with("\nBack then;\nI did it;")
        end
      end

      context "when path is second article" do
        let(:path) { "spec/fixtures/answering-a-comment-about-delete-all-your-tests" }

        it "is correct" do
          expect(subject.body).to start_with("\n\nMatthias Berth is a German expert")
        end
      end
    end

    describe "#categories" do
      context "when path is first article" do
        let(:path) { "spec/fixtures/a-neverending-story" }

        it "is correct" do
          expect(subject.categories).to eq(["article"])
        end
      end

      context "when path is second article" do
        let(:path) { "spec/fixtures/answering-a-comment-about-delete-all-your-tests" }

        it "is correct" do
          expect(subject.categories).to eq(%w(article code\ review quality))
        end
      end
    end
  end
end
