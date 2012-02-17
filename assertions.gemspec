# -*- encoding: utf-8 -*-
$LOAD_PATH.push(File.expand_path "../lib", __FILE__)
require "assertions/version"

Gem::Specification.new do |gem|
  gem.authors     = ["DesigningPatterns", "Expected Behavior"]
  gem.email       = ["technical.inquiries@designingpatterns.com",
                     "joel@expectedbehavior.com",
                     "chris@monoclesoftware.com"]
  gem.description = %{This project adds some additional assertions to Test::Unit::Assertions, including assert_raise_message (allowing verification of error messages) and assert_greater_than.}
  gem.summary     = "More Assertions for Test::Unit::Assertions"
  gem.homepage    = "http://www.expectedbehavior.com"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "assertions"
  gem.require_paths = ["lib"]
  gem.version       = Assertions::VERSION
end
