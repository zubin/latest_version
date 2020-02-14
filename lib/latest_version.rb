# frozen_string_literal: true

Dir[File.expand_path('latest_version/**/*.rb', __dir__)].each(&method(:require))

require 'net/http'
require 'uri'

module LatestVersion
  LIBRARIES = {
    python: lambda {
      find(
        url: 'https://www.python.org/',
        regex: %r{<p>Latest: <a href="/downloads/release/python-\d+/">Python (\d+\.\d+\.\d+)</a></p>},
      )
    },
    rails: lambda {
      find(url: 'https://rubyonrails.org/', regex: /Latest version &mdash; Rails ([\d\.]+)/)
    },
    ruby: lambda {
      find(url: 'https://www.ruby-lang.org/en/downloads/', regex: /current stable version is (\d+\.\d+\.\d+)\./)
    },
  }.freeze
  UnknownLibraryError = Class.new(StandardError)
  private_constant :LIBRARIES

  def self.call(library)
    LIBRARIES.fetch(library.to_sym) { raise UnknownLibraryError, library }.call
  end

  private_class_method def self.find(url:, regex:)
    Net::HTTP.get(URI.parse(url))[regex, 1]
  end
end
