# frozen_string_literal: true

require 'net/http'
require 'uri'

Dir[File.expand_path('latest_version/**/*.rb', __dir__)].each(&method(:require))

module LatestVersion
  LIBRARIES = {
    'ruby' => Libraries::Ruby,
  }.freeze
  private_constant :LIBRARIES

  def self.call(library)
    LIBRARIES.fetch(library) { raise NotImplementedError, library }.call
  end
end
