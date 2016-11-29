# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mercury_web_parser/version', __FILE__)

Gem::Specification.new do |s|
  s.name           = 'mercury_web_parser'
  s.version        = MercuryWebParser::VERSION
  s.summary        = 'A simple Ruby wrapper for the Mercury Web Parser API'
  s.authors        = ['Jim Fiorato']
  s.email          = 'mercury_web_parser@theoldreader.com'
  s.homepage       = 'http://github.com/theoldreader/mercury-web-parser'
  s.license        = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_development_dependency 'danger'
  s.add_development_dependency 'danger-commit_lint'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'vcr'
end
