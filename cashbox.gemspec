# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cashbox/version'

Gem::Specification.new do |spec|
  spec.name          = 'cashbox'
  spec.version       = Cashbox::VERSION
  spec.authors       = ['Jonathon Storer']
  spec.email         = ['engineering@legalshieldcorp.com']

  spec.required_ruby_version = '~> 2.0'

  spec.summary       = %q{Cashbox Rest Client}
  spec.description   = %q{Cashbox Rest Client}
  spec.homepage      = 'https://github.com/legalshield/cashbox'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2'
  spec.add_development_dependency 'webmock', '~> 2.0'
  spec.add_development_dependency 'pry-byebug', '~> 2.0'

  spec.add_dependency 'httparty'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'hashie'
  spec.add_dependency 'addressable'
end
