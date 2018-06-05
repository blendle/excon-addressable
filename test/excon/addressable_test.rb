# frozen_string_literal: true

require_relative '../test_helper'

module Excon
  # AddressableTest
  #
  # Verifies the templated uri being parsed correctly by Addressable::Template.
  #
  class AddressableTest < Minitest::Test
    def setup
      Excon.defaults[:middlewares].unshift(Excon::Addressable::Middleware)
      Excon.defaults[:mock] = true
      Excon.stub({ path: '/' }, body: 'index')
      Excon.stub({ path: '/hello' }, body: 'world')
      Excon.stub({ path: '/hello', query: 'message=world' }, body: 'hi!')
      Excon.stub({ path: '/hello', query: 'a=b&c=d' }, body: 'earth')
      Excon.stub({ path: '/world' }, body: 'universe')
      Excon.stub({ path: '/foo' }, { headers: { 'Location' => '/bar' }, body: 'no', status: 301 })
      Excon.stub({ path: '/bar' }, { body: 'ok!', status: 200 })
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
      connection = Excon.new('http://www.example.com/{uid}{?message}', expand: { uid: 'goodbye' })
      response   = connection.get(expand: { uid: 'hello', message: 'world' })

      assert_equal 'hi!', response.body
    end

    def test_uri_with_full_uri
      response = Excon.get('http://www.example.com/hello?message=world')

      assert_equal 'hi!', response.body
    end

    def test_uri_with_query
      response = Excon.get('http://www.example.com/hello', query: { message: 'world' })

      assert_equal 'hi!', response.body
    end

    def test_uri_with_multiple_queries
      response = Excon.get('https://www.example.com/hello', query: { a: 'b', c: 'd' })

      assert_equal 'earth', response.body
    end

    def test_uri_with_redirect
      response = Excon.get(
        'https://www.example.com/foo',
        middlewares: Excon.defaults[:middlewares] + [Excon::Middleware::RedirectFollower]
      )

      assert_equal 'ok!', response.body
    end

    def teardown
      Excon.stubs.clear
    end
  end
end
