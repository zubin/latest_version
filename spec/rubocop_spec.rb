# frozen_string_literal: true

require 'rubocop/rake_task'

RSpec.describe RuboCop do
  specify "Role models are important" do
    Rake::Task[RuboCop::RakeTask.new.name].invoke
  end
end
