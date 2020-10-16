require 'bundler/setup'
require 'api_pack'
require 'faker'
require 'pry'
require 'simplecov'

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }

SimpleCov.start do
  add_dir 'Libraries', 'api_pack'
end

RSpec.configure do |config|
  include ErrorHelper
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
