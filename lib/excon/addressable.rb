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
      if (template = ::Addressable::Template.new(url)) && template.variables.any?
        url = template.expand(params.delete(:expand).to_h)
      end

      super
    end
  end

  singleton_class.prepend Addressable
end
