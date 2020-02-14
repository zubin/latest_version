# frozen_string_literal: true

require 'net/http'
require 'uri'

module LatestVersion
  LIBRARIES = {
    python: lambda {
      find_text(
        url: 'https://www.python.org/',
        regex: %r{<p>Latest: <a href="/downloads/release/python-\d+/">Python (\d+\.\d+\.\d+)</a></p>},
      )
    },
    rails: lambda {
      find_text(url: 'https://rubyonrails.org/', regex: /Latest version &mdash; Rails ([\d\.]+)/)
    },
    ruby: lambda {
      find_text(url: 'https://www.ruby-lang.org/en/downloads/', regex: /current stable version is (\d+\.\d+\.\d+)\./)
    },
  }.freeze
  UnknownLibraryError = Class.new(StandardError)
  private_constant :LIBRARIES

  def self.call(library)
    LIBRARIES.fetch(library.to_sym) { raise UnknownLibraryError, library }.call
  end

  def self.supported_libraries
    LIBRARIES.keys.sort
  end

  private_class_method def self.find_text(url:, regex:)
    Net::HTTP.get(URI.parse(url))[regex, 1]
  end
end
