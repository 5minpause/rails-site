# frozen_string_literal: true

require "rake"

# Inspired from https://robots.thoughtbot.com/test-rake-tasks-like-a-boss
RSpec.shared_context "with rake" do
  let(:task)      { rake[task_name] }

  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/#{task_name.split(':').join('/')}" }

  def loaded_files_excluding_current_rake_file
    $LOADED_FEATURES.reject { |file| file == Rails.root.join(task_path).to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [Rails.root.to_s], loaded_files_excluding_current_rake_file)
    Rake::Task.define_task(:environment)
  end
end
