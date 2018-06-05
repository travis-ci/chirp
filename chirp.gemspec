# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chirp/version'

Gem::Specification.new do |spec|
  spec.name = 'chirp'
  spec.version = Chirp::VERSION
  spec.authors = ['Dan Buch']
  spec.email = ['contact+chirp@travis-ci.org']

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://example.org/nope/nope/nope'
  end

  spec.summary = 'Canary thing'
  spec.description = 'Canary thing with flair!'
  spec.homepage = 'https://github.com/travis-infrastructure/chirp'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
