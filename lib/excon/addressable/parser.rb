# frozen_string_literal: true

module Excon
  module Addressable
    # Parser
    #
    # Parses a url using `Addressable`, setting the port to the inferred_port.
    #
    # @see : https://github.com/excon/excon/issues/384#issuecomment-42645517
    # @see : https://github.com/excon/excon/issues/384#issuecomment-362618298
    #
    class Parser
      def self.parse(url)
        uri = ::Addressable::URI.parse(url)
        uri.port = uri.inferred_port unless uri.port
        uri
      end
    end
  end
end
