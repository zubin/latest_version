# frozen_string_literal: true

module LatestVersion
  module Find
    def self.call(url:, regex:)
      Net::HTTP.get(URI.parse(url))[regex, 1]
    end
  end
end
