spec = Gem::Specification.new do |s|
  s.name = 'assertions'
  s.version = '1.7.0'
  s.summary = "More Assertions for Test::Unit::Assertions"
  s.description = %{This project adds some additional assertions to Test::Unit::Assertions, including assert_raise_message (allowing verification of error messages) and assert_greater_than.}
  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb'] + Dir['examples/**/*.rb']
  s.require_path = 'lib'
  s.autorequire = 'assertions'
  s.has_rdoc = true
  s.extra_rdoc_files = Dir['[A-Z]*']
  s.rdoc_options << '--title' <<  'Assertions'
  s.authors = ["DesigningPatterns", "Expected Behavior"]
  s.email = "technical.inquiries@designingpatterns.com"
  s.homepage = "http://www.rubyforge.org/projects/assertions"
end
