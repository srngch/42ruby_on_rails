# frozen_string_literal: true

require_relative "lib/ft_wikipedia/version"

Gem::Specification.new do |spec|
  spec.name          = "ft_wikipedia"
  spec.version       = Ft_wikipedia::VERSION
  spec.authors       = ["sarchoi"]
  spec.email         = ["42.4.sarchoi@gmail.com"]

  spec.summary       = "the path to philosophy."
  spec.description   = "Exercise 01: ft_wikipedia in Day03, Ruby on Rails Pisine"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"
  spec.files = Dir['lib/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "minitest", "~> 5.0"
  spec.add_dependency "nokogiri", "~> 1.11"
  spec.add_dependency "open-uri", "~> 0.1.0"
end
