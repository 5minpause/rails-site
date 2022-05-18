# frozen_string_literal: true

require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "Authentication" do
  context "when guest" do
    it "is not possible to edit an article" do
      article = Article.create!(
        title: "My title"
      )

      visit "/articles/#{article.id}/edit"

      expect(page).to have_content("Please sign in to continue")
    end
  end

  context "when registered user" do
    let!(:article) do
      Article.create!(
        title: "My title",
        published_at: Time.current,
        content: "Awesome content"
      )
    end

    let(:user) { create(:user, email: "user@example.com", password: "password") }

    it "is possible to edit an article" do
      sign_in_with user.email, "password"

      visit "/articles/#{article.id}/edit"

      expect(page).to have_content("Editing article")
    end
  end
end
