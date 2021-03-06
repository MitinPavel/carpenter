# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "carpenter/version"

Gem::Specification.new do |s|
  s.name        = "carpenter"
  s.version     = Carpenter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mitin Pavel"]
  s.email       = ["mitin.pavel@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "carpenter"

  s.add_development_dependency "rspec", '~> 2.5.0'
  s.add_development_dependency "cucumber"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
end
