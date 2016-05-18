# Excon::Addressable [![wercker status](https://app.wercker.com/status/3868c162aa140566b830f517c45d528a/s/master "wercker status")](https://app.wercker.com/project/bykey/3868c162aa140566b830f517c45d528a)

Sets [Addressable][addressable] as the default URI parser. Supports parsing
[templated uris][].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'excon-addressable'
```

And then execute:

```shell
bundle
```

Or install it yourself as:

```shell
gem install excon-addressable
```

## Usage

Be sure to add `Excon::Addressable::Middleware` to the top of the middleware
stack, so that the variables get expanded as early as possible. This prevents
other middleware from choking on non-valid URIs.

```ruby
Excon.defaults[:middlewares].unshift(Excon::Addressable::Middleware)
```

Then simply provide a templated variable, and the values with which to expand
the template:

```ruby
conn = Excon.new('http://www.example.com/{uid}', expand: { uid: 'hello' })
conn.request.path # => '/hello'
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[addressable]: https://github.com/sporkmonger/addressable
[templated uris]: https://github.com/sporkmonger/addressable#uri-templates
