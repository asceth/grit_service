$:.push File.expand_path("../lib", __FILE__)
require "grit_service/version"

Gem::Specification.new do |s|
  s.name        = "grit_service"
  s.version     = GritService::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John 'asceth' Long"]
  s.email       = ["machinist@asceth.com"]
  s.homepage    = "http://github.com/asceth/grit_service"
  s.summary     = "Ernie's got Grit"
  s.description = "Turns Grit into an Ernie service"

  s.rubyforge_project = "grit_service"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'grit'
  s.add_dependency 'bert'
  s.add_dependency 'bertrpc'
  s.add_dependency 'ernie'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rr'
end

