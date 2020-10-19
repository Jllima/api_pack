source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

gem 'fast_jsonapi'
gem 'jwt'

group :test do
  gem 'coveralls', require: false
  gem 'faker'
  gem 'rspec', '~> 3.7'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'bundler-audit'
  gem 'fasterer'
  gem 'overcommit'
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
end
