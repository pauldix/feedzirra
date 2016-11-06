# -*- encoding: utf-8 -*-
require File.expand_path('../lib/feedjira/version', __FILE__)

Gem::Specification.new do |s|
  s.authors  = ['Paul Dix', 'Julien Kirch', 'Ezekiel Templin', 'Jon Allured']
  s.email    = 'feedjira@gmail.com'
  s.homepage = 'http://feedjira.com'
  s.license  = 'MIT'
  s.name     = 'feedjira'
  s.platform = Gem::Platform::RUBY
  s.summary  = 'A feed fetching and parsing library'
  s.version  = Feedjira::VERSION

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_runtime_dependency 'faraday'
  s.add_runtime_dependency 'faraday_middleware'
  s.add_runtime_dependency 'loofah'
  s.add_runtime_dependency 'sax-machine'

  s.add_development_dependency 'danger'
  s.add_development_dependency 'danger-commit_lint'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
end
