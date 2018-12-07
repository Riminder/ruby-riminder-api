Gem::Specification.new do |s|
  s.name        = 'Riminder'
  s.version     = '1.1.0'
  s.licenses    = ['MIT']
  s.summary     = "A ruby api client for Riminder api."
  s.description = "A api client for riminder, permit to access and manipulate some Riminder's services without the web interface."
  s.authors     = ["Gotte Alexandre"]
  s.email       = 'contact@riminder.net'
  s.files       = ["lib/filter.rb", "lib/profile.rb", "lib/requtils.rb", "lib/restClientW.rb", "lib/riminderException.rb", "lib/riminder.rb", "lib/source.rb", "lib/webhook.rb"]
  s.homepage    = 'https://riminder.net'
  s.metadata    = { "source_code_uri" => "https://github.com/Riminder/ruby-riminder-api" }
  s.required_ruby_version = '~> 2.5'
  s.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  s.add_runtime_dependency 'activesupport', '~> 5.0'
  s.add_development_dependency 'rubocop', '~> 0.58.2'
  s.add_development_dependency 'rspec', '~> 3.5'
end