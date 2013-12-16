# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'giffy/version'

Gem::Specification.new do |spec|
  spec.name          = "giffy"
  spec.version       = Giffy::VERSION
  spec.authors       = ["Shopify", "Chris Saunders"]
  spec.email         = ["chris.saunders@shopify.com"]
  spec.description   = "A tool that makes it easy to convert videos into gifs"
  spec.summary       = "Using existing tools such as ffmpeg and ImageMagick easily create gifs"
  spec.homepage      = "https://github.com/Shopify/giffy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", ">= 5.0.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
end
