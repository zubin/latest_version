# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module LatestVersion
  LIBRARIES = {
    elixir: -> { latest_github_release(repo: 'elixir-lang/elixir') },
    python: lambda {
      find_text(
        url: 'https://www.python.org/',
        regex: %r{<p>Latest: <a href="/downloads/release/python-\d+/">Python (\d+\.\d+\.\d+)</a></p>},
      )
    },
    rails: -> { of_rubygem('rails') },
    ruby: -> { latest_github_tag(repo: 'ruby/ruby').gsub('_', '.') },
    rust: -> { latest_github_tag(repo: 'rust-lang/rust') },
  }.freeze
  UnknownLibraryError = Class.new(StandardError)
  private_constant :LIBRARIES

  def self.of(library)
    LIBRARIES.fetch(library.to_sym) { raise UnknownLibraryError, library }.call
  end

  def self.of_rubygem(gem_name)
    json = Net::HTTP.get(URI("https://rubygems.org/api/v1/versions/#{gem_name}/latest.json"))
    JSON.parse(json, symbolize_names: true).fetch(:version)
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
    tags.map { |tag| tag.fetch(:name).gsub(/^v/, '') }.reject { |name| name[/[a-z]/i] }.max
  end
end
