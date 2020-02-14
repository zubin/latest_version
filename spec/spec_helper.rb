# frozen_string_literal: true

require 'bundler/setup'
require 'latest_version'

Dir[File.expand_path('support/**/*.rb', __dir__)].each(&method(:require))

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
