# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'excon/addressable/version'

Gem::Specification.new do |spec|
  spec.name          = 'excon-addressable'
  spec.version       = Excon::Addressable::VERSION
  spec.authors       = %w[Jean Mertz]
  spec.email         = %w[jean@mertz.fm]

  spec.summary       = 'Excon, with Addressable baked in.'
  spec.description   = 'Excon, with Addressable baked in.'
  spec.homepage      = 'https://github.com/JeanMertz/excon-addressable'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rubocop', '~> 0.52'

  spec.add_dependency 'addressable', '~> 2.5'
  spec.add_dependency 'excon', '~> 0.60'
end
