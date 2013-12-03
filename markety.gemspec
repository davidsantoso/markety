Gem::Specification.new do |gem|
  gem.name        = "markety"
  gem.version      = "1.0.0"
  gem.summary     = "A client to allow easy integration with Marketo's SOAP API"
  gem.description = "Allows easy integration with marketo from Ruby. You can synchronize leads and fetch them back by email. By default this is configured for the SOAP WSDL file: http://app.marketo.com/soap/mktows/2_2?WSDL, but this is configurable when you construct the client.

client = Markety.new_client(<access_key>, <secret_key>, (api_subdomain = 'na-i'), (api_version = '1_5'), (document_version = '1_4'))"
  gem.email        = "david.e.santoso@gmail.com"
  gem.authors      = ["David Santoso"]
  gem.files        = Dir['lib/**/*.rb']
  gem.homepage     = "https://github.com/davidsantoso/markety"
  gem.require_path = ['lib']
  gem.test_files   = Dir['spec/**/*_spec.rb']
  gem.add_development_dependency('rspec', '>= 2.3.0')
  gem.add_dependency('savon', '~> 2.3.0')
end
