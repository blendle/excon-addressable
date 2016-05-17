# Excon::Addressable

Sets [Addressable][] as the default URI parser. Supports parsing [templated uris][].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'excon-addressable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install excon-addressable

## Usage

```ruby
conn = Excon.new('http://www.example.com/{uid}', expand: { uid: 'hello' })
conn.request.path # => '/hello'
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[Addressable]: https://github.com/sporkmonger/addressable
[templated uris]: https://github.com/sporkmonger/addressable#uri-templates
