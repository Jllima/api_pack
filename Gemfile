source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

gem 'fast_jsonapi'
gem 'jwt'

group :test do
  gem 'faker'
  gem 'rspec', '~> 3.7'
end

group :development, :test do
  gem 'bundler-audit'
  gem 'coveralls_reborn', '~> 0.18.0', require: false
  gem 'fasterer'
  gem 'overcommit'
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'simplecov', require: false
end
