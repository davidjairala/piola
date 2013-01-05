# -*- encoding: utf-8 -*-
require File.expand_path('../lib/piola/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Jairala"]
  gem.email         = ["davidjairala@gmail.com"]
  gem.description   = %q{String extensions and quality of life methods}
  gem.summary       = %q{Provides a bunch of extensions for Strings, HTML manipulation methods, splitting, spanish language quality of life, etc.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "piola"
  gem.require_paths = ["lib"]
  gem.version       = Piola::VERSION

  gem.add_dependency 'htmlentities',  ["~> 4.3.1"]
  gem.add_dependency 'activesupport', [">= 3.0.0"]
end
