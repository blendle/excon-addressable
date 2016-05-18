# frozen_string_literal: true
require 'addressable'
require 'excon'
require 'excon/addressable/version'

Excon.defaults[:uri_parser] = Addressable::URI

module Excon
  module Addressable
    # Middleware
    #
    # Parses a Templated URI string and merges it with the provided variables.
    #
    class Middleware < Excon::Middleware::Base
      def request_call(datum)
        url = ::Addressable::URI.new(datum)

        if (template = ::Addressable::Template.new(url)) && template.variables.any?
          uri = template.expand(datum[:expand].to_h)
          datum.merge!(uri.to_hash)
        end

        super
      end
    end
  end
end
