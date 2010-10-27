# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "outdated-gems/version"

Gem::Specification.new do |s|
  s.name        = "outdated-gems"
  s.version     = Outdated::Gems::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aaron Gibralter"]
  s.email       = ["aaron.gibralter@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/outdated-gems"
  s.summary     = %q{Run `outdated_gems` after `bundle update/install` to see which of your gems are outdated.}
  s.description = %q{Run `outdated_gems` after `bundle update/install` to see which of your gems are outdated.}

  s.rubyforge_project = "outdated-gems"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
