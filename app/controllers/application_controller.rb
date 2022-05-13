class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_action :display_session_links

  private

  def display_session_links
    @display_sessions_links = params[ENV.fetch("PARAM_NAME", "foo").to_sym] == ENV.fetch("PARAM_PW", "bar")
  end
end
