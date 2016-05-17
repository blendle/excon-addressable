# frozen_string_literal: true
require_relative '../test_helper'

module Excon
  # AddressableTest
  #
  # Verifies the templated uri being parsed correctly by Addressable::Template.
  #
  class AddressableTest < Minitest::Test
    def setup
      Excon.defaults[:mock] = true
      Excon.stub({ path: '/hello' }, body: 'world')
      Excon.stub({ path: '/world' }, body: 'universe')
    end

    def test_expand_templated_uri
      conn = Excon.new('http://www.example.com/{uid}', expand: { uid: 'hello' })

      assert_equal '/hello', conn.data[:path]
      assert_equal 200, conn.get.status
    end

    def test_templated_uri_with_optional_query_parameters
      conn = Excon.new('http://www.example.com/{?uid}')

      assert_equal '/', conn.data[:path]
    end

    def test_templated_uri_with_excon_shortcut_method
      response = Excon.get('http://www.example.com/{uid}', expand: { uid: 'world' })

      assert_equal 'universe', response.body
    end

    def teardown
      Excon.stubs.clear
    end
  end
end
