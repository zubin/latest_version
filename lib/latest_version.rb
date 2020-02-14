# frozen_string_literal: true

require 'net/http'
require 'uri'

Dir[File.expand_path('latest_version/**/*.rb', __dir__)].each(&method(:require))

module LatestVersion
  LIBRARIES = {
    'python' => Libraries::Python,
    'rails' => Libraries::Rails,
    'ruby' => Libraries::Ruby,
  }.freeze
  UnknownLibraryError = Class.new(StandardError)
  private_constant :LIBRARIES

  def self.call(library)
    LIBRARIES.fetch(library) { raise UnknownLibraryError, library }.call
  end
end
