# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'excon/addressable/version'

Gem::Specification.new do |spec|
  spec.name          = 'excon-addressable'
  spec.version       = Excon::Addressable::VERSION
  spec.authors       = %w(Jean Mertz)
  spec.email         = %w(jean@mertz.fm)

  spec.summary       = 'Excon, with Addressable baked in.'
  spec.description   = 'Excon, with Addressable baked in.'
  spec.homepage      = 'https://github.com/JeanMertz/excon-addressable'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 0.40.0'
  spec.add_development_dependency 'pry', '~> 0.10'

  spec.add_dependency 'excon', '~> 0.49'
  spec.add_dependency 'addressable', '~> 2.3'
end
