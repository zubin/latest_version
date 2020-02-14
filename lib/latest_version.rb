# frozen_string_literal: true

require 'net/http'
require 'uri'

Dir[File.expand_path('latest_version/**/*.rb', __dir__)].each(&method(:require))

module LatestVersion
  LIBRARIES = {
    python: -> { Find.call(url: 'https://www.python.org/', regex: %r{<p>Latest: <a href="/downloads/release/python-\d+/">Python (\d+\.\d+\.\d+)</a></p>}) },
    rails: -> { Find.call(url: 'https://rubyonrails.org/', regex: /Latest version &mdash; Rails ([\d\.]+)/) },
    ruby: -> { Find.call(url: 'https://www.ruby-lang.org/en/downloads/', regex: /The current stable version is (\d+\.\d+\.\d+)\./) },
  }.freeze
  UnknownLibraryError = Class.new(StandardError)
  private_constant :LIBRARIES

  def self.call(library)
    LIBRARIES.fetch(library.to_sym) { raise UnknownLibraryError, library }.call
  end
end
