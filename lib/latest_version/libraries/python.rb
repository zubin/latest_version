# frozen_string_literal: true

module LatestVersion
  module Libraries
    module Python
      URL = 'https://www.python.org/'
      REGEX = %r{<p>Latest: <a href="/downloads/release/python-\d+/">Python (\d+\.\d+\.\d+)</a></p>}.freeze
      private_constant :URL, :REGEX

      def self.call
        Net::HTTP.get(URI.parse(URL))[REGEX, 1]
      end
    end
  end
end
