
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_pack/version'

Gem::Specification.new do |spec|
  spec.name          = 'api_pack'
  spec.version       = ApiPack::VERSION
  spec.authors       = ['Jorge']
  spec.email         = ['jlimajorge@gmail.com']

  spec.summary       = 'Api requirements pack for api rails development'
  spec.description   = 'Api requirements pack for api rails development'
  spec.homepage      = ''
  spec.license       = 'MIT'

  raise 'RubyGems 2.4 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
