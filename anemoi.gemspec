# -*- encoding: utf-8 -*-
require File.expand_path('../lib/anemoi/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["kkosuge"]
  gem.email         = ["kkosuge@about.me"]
  gem.description   = %q{get weather forecast from expression with natural language (ONLY IN JAPANESE)}
  gem.summary       = %q{get weather forecast from expression with natural language (ONLY IN JAPANESE)}
  gem.homepage      = "https://github.com/kkosuge/Anemoi"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "anemoi"
  gem.require_paths = ["lib"]
  gem.version       = Anemoi::VERSION

  gem.add_dependency "httparty"
  gem.add_dependency "horai"
  gem.add_dependency "nokogiri"
  gem.add_development_dependency "rspec"
end
