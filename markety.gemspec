# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markety/version'

Gem::Specification.new do |s|
  s.name          = 'markety'
  s.version       = Markety::VERSION
  s.summary       = 'Marketo SOAP API integration'
  s.description   = <<-DESC.strip
    A client to allow easy integration with Marketo's SOAP API
  DESC
  s.authors       = ['David Santoso']
  s.email         = ['david.e.santoso@gmail.com']
  s.homepage      = 'https://github.com/davidsantoso/markety'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency  'bundler', '~> 1.6'
  s.add_development_dependency  'rake'
  s.add_development_dependency  'rspec', '~> 2.3', '>= 2.3.0'
  s.add_development_dependency  'rspec-nc'
  s.add_development_dependency  'pry'

  s.add_runtime_dependency      'savon', '~> 2.3'
  s.add_runtime_dependency      'wasabi', '~> 3.2'
end
