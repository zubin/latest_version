# frozen_string_literal: true

require 'json'
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
    rails: -> { latest_github_release(repo: 'rails/rails') },
    ruby: -> { latest_github_tag(repo: 'ruby/ruby').gsub('_', '.') },
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

  private_class_method def self.latest_github_release(repo:)
    json = Net::HTTP.get(URI("https://api.github.com/repos/#{repo}/releases/latest"))
    JSON.parse(json, symbolize_names: true).fetch(:tag_name).gsub(/^v/, '')
  end

  private_class_method def self.latest_github_tag(repo:)
    json = Net::HTTP.get(URI("https://api.github.com/repos/#{repo}/tags"))
    tags = JSON.parse(json, symbolize_names: true)
    tags.map { |tag| tag.fetch(:name).gsub(/^v/, '') }.reject { |name| name[/beta|preview|rc/] }.max
  end
end
