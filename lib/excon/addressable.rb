# frozen_string_literal: true
require 'addressable'
require 'excon'
require 'excon/addressable/version'

Excon.defaults[:uri_parser] = Addressable::URI

# :nodoc:
module Excon
  # :nodoc:
  class Connection
    # Addressable addition to Excon.
    #
    module Addressable
      def request(params = {}, &block)
        expand = @data[:expand].to_h.merge(params[:expand].to_h)
        url = ::Addressable::URI.new(@data)

        if (template = ::Addressable::Template.new(url)) && template.variables.any?
          uri = template.expand(expand)

          @data[:scheme] = uri.scheme
          @data[:host]   = uri.host
          @data[:port]   = uri.port
          @data[:path]   = uri.path
          @data[:query]  = uri.query
        end

        super
      end
    end

    prepend Addressable
  end
end
