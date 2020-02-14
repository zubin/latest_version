# frozen_string_literal: true

module LatestVersion
  module Libraries
    module Ruby
      URL = 'https://www.ruby-lang.org/en/downloads/'
      REGEX = /The current stable version is (\d+\.\d+\.\d+)\./.freeze
      private_constant :URL, :REGEX

      def self.call
        Net::HTTP.get(URI.parse(URL))[REGEX, 1]
      end
    end
  end
end
