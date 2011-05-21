$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'town/version'

Gem::Specification.new do |s|
  s.name = "town-core"
  s.version = Town::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.authors = ["Peter Sowerbutts"]
  s.summary = %q{Lib for simulating the people in a Town}
  s.files = %w[README Rakefile town.gemspec]
  s.files += Dir['lib/*.rb'] + Dir['lib/town/*.rb'] + Dir['spec/*.rb']
  s.executables = ["town"]
end
