# frozen_string_literal: true

require_relative 'lib/latest_version/version'

Gem::Specification.new do |spec|
  spec.name          = 'latest_version'
  spec.version       = LatestVersion::VERSION
  spec.authors       = ["Zubin Henner"]
  spec.email         = ['zubin@users.noreply.github.com']

  spec.summary       = "Look up latest versions of open source libraries from your shell."
  spec.homepage      = 'https://github.com/zubin/latest_version'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.metadata['source_code_uri']}CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'

  spec.add_development_dependency 'climate_control'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
