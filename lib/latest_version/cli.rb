# frozen_string_literal: true

require 'thor'
require 'latest_version'
require 'latest_version/completion'

module LatestVersion
  class CLI < Thor
    private_class_method def self.exit_on_failure?
      true
    end

    LatestVersion.supported_libraries.each do |library|
      desc library, "Returns latest version of #{library}"
      define_method(library) { puts LatestVersion.of(library) }
    end

    desc 'completion SHELL', "Installs shell completion"
    subcommand 'completion', Completion::Install

    desc 'completions', "Lists supported completions"
    def completions
      puts Completion::SUPPORTED.keys.join("\n")
    end
  end
end
