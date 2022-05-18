# frozen_string_literal: true

module Features
  # Helper methods taken from https://github.com/thoughtbot/clearance#ready-made-feature-specs
  module ClearanceHelpers
    def reset_password_for(email)
      visit new_password_path(params: { foo: "bar" })
      fill_in "password_email", with: email
      click_button I18n.t("helpers.submit.password.submit")
    end

    def sign_in
      password = "password"
      user = FactoryBot.create(:user, password: password)
      sign_in_with user.email, password
    end

    def sign_in_with(email, password)
      visit sign_in_path(params: { foo: "bar" })
      fill_in "session_email", with: email
      fill_in "session_password", with: password
      click_button I18n.t("helpers.submit.session.submit")
    end

    def sign_out
      click_button I18n.t("layouts.application.sign_out")
    end

    def sign_up_with(email, password)
      visit sign_up_path(params: { foo: "bar" })
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_button I18n.t("helpers.submit.user.create")
    end

    def expect_user_to_be_signed_in
      visit root_path(params: { foo: "bar" })
      expect(page).to have_button I18n.t("layouts.application.sign_out")
    end

    def expect_user_to_be_signed_out
      expect(page).to have_content I18n.t("layouts.application.sign_in")
    end

    def user_with_reset_password
      user = FactoryBot.create(:user)
      reset_password_for user.email
      user.reload
    end
  end
end

RSpec.configure do |config|
  config.include Features::ClearanceHelpers, type: :feature
end
