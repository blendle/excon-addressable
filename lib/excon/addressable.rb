# frozen_string_literal: true
require 'addressable'
require 'excon'
require 'excon/addressable/version'

Excon.defaults[:uri_parser] = Addressable::URI

# :nodoc:
module Excon
  # Addressable addition to Excon.
  #
  module Addressable
    def new(url, params = {})
      if (variables = params.delete(:expand))
        url = ::Addressable::Template.new(url).expand(variables)
      end

      super
    end
  end

  singleton_class.prepend Addressable
end
