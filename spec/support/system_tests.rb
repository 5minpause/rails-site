# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end

# Configure Capybara expected host
host_url = "http://#{ENV.fetch('DEFAULT_HOST')}"
Capybara.app_host = host_url

# Configure actual routes host during test
# before(:each) do
#   default_url_options[:host] = host_url
# end
