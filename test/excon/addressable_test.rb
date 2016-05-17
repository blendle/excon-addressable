require_relative '../test_helper'

module Excon
  # AddressableTest
  #
  # Verifies the templated uri being parsed correctly by Addressable::Template.
  #
  class AddressableTest < Minitest::Test
    def setup
      Excon.defaults[:mock] = true
      Excon.stub({}, status: 200)
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

    def teardown
      Excon.stubs.clear
    end
  end
end
