# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors, debug: true do
  # allow do
  #   origins "holgerfrohloffde-assets-development.s3.eu-central-1.amazonaws.com"
  #   resource '*',
  #     :headers => :any,
  #     :methods => [:get, :post, :delete, :put, :patch, :options, :head],
  #     :max_age => 0
  # end

  allow do
    origins 'holgerfrohloffde-assets-development.s3.eu-central-1.amazonaws.com'
    resource '*',
      :headers => :any,
      :methods => [:get, :post, :delete, :put, :patch, :options, :head],
      credentials: true
  end

  allow do
    origins '*'
    resource '*',
      :headers => :any,
      :methods => [:get, :post, :delete, :put, :patch, :options, :head],
      credentials: false
  end
end
