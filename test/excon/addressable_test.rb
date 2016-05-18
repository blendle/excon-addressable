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
      Excon.stub({ path: '/' }, body: 'index')
      Excon.stub({ path: '/hello' }, body: 'world')
      Excon.stub({ path: '/world' }, body: 'universe')
    end

    def test_expand_templated_uri
      connection = Excon.new('http://www.example.com/{uid}', expand: { uid: 'hello' })
      response   = connection.get

      assert_equal 'world', response.body
    end

    def test_templated_uri_with_optional_query_parameters
      connection = Excon.new('http://www.example.com/{?uid}')
      response   = connection.get

      assert_equal 'index', response.body
    end

    def test_templated_uri_with_excon_shortcut_method
      response = Excon.get('http://www.example.com/{uid}', expand: { uid: 'world' })

      assert_equal 'universe', response.body
    end

    def test_templated_uri_with_mixed_connection_and_get
      connection = Excon.new('http://www.example.com/{uid}')
      response   = connection.get(expand: { uid: 'world' })

      assert_equal 'universe', response.body
    end

    def test_templated_uri_overriding_variables
      connection = Excon.new('http://www.example.com/{uid}', expand: { uid: 'hello' })
      response   = connection.get(expand: { uid: 'world' })

      assert_equal 'universe', response.body
    end

    def teardown
      Excon.stubs.clear
    end
  end
end
