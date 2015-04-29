# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "time_for_a_boolean/version"

Gem::Specification.new do |spec|
  spec.name = "time_for_a_boolean"
  spec.version = TimeForABoolean::VERSION
  spec.authors = ["Caleb Thompson"]
  spec.email = ["caleb@calebthompson.io"]
  spec.description = <<-DESCRIPTION
    Use timestamp values to represent boolean data such as deleted, published,
    or subscribed.
  DESCRIPTION
  spec.summary = "Back boolean values with timestamps"
  spec.homepage = "https://github.com/calebthompson/time_for_a_boolean"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_dependency "railties"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
