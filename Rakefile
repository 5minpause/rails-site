# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

begin
  require "rubocop/rake_task"

  RuboCop::RakeTask.new do |task|
    task.options << "-EASD"
    if (added_args = ARGV[2..])
      task.options += added_args
    end
  end
rescue LoadError
  # no rubocop available
end

begin
  require "rspec/core/rake_task"

  task("spec").clear

  desc "Run everything except specs tagged as 'feature'"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = "--exclude-pattern ./spec/system/\\*\\*/\\*_spec.rb --tag ~type:system"
  end

  task("spec:system").clear
  desc "Run only specs tagged as 'system'"
  RSpec::Core::RakeTask.new(:"spec:system") do |t|
    t.rspec_opts = "--tag type:system"
  end

  desc "Run all the specs regardless of tags"
  RSpec::Core::RakeTask.new(:"spec:all")

  task default: :spec
rescue LoadError
  # no rspec available
end
