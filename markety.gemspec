lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markety/version'

Gem::Specification.new do |s|
  s.name         = "markety"
  s.version      = Markety::VERSION
  s.summary      = "Marketo SOAP API integration"
  s.description  = "A client to allow easy integration with Marketo's SOAP API"
  s.authors      = "David Santoso"
  s.email        = "david.e.santoso@gmail.com"
  s.homepage     = "https://github.com/davidsantoso/markety"
  s.files        = Dir['lib/**/*.rb']
  s.license      = 'MIT'
  s.require_path = 'lib'
  s.required_ruby_version       = '>= 1.9.3'
  s.add_dependency             'savon', '= 2.3.1'
  s.add_dependency             'wasabi', '= 3.2.1'
  s.add_development_dependency 'rspec', '~> 2.3', '>= 2.3.0'
end
