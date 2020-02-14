# frozen_string_literal: true

module LatestVersion
  module Libraries
    module Rails
      URL = 'https://rubyonrails.org/'
      REGEX = /Latest version &mdash; Rails ([\d\.]+) /.freeze
      private_constant :URL, :REGEX

      def self.call
        Net::HTTP.get(URI.parse(URL))[REGEX, 1]
      end
    end
  end
end
