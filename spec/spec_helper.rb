# frozen_string_literal: true

require 'bundler/setup'
require 'latest_version'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
