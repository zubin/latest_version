# frozen_string_literal: true

require 'thor'
require 'latest_version'

module LatestVersion
  class CLI < Thor
    private_class_method def self.exit_on_failure?
      true
    end

    LatestVersion.supported_libraries.each do |library|
      desc library, "Returns latest version of #{library}"
      define_method(library) do
        puts LatestVersion.call(library)
      end
    end
  end
end
