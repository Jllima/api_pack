require 'bundler/setup'

require 'coveralls'
Coveralls.wear!

require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter,
                                                                Coveralls::SimpleCov::Formatter])
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
end

require 'api_pack'
require 'faker'
require 'pry'

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }


RSpec.configure do |config|
  include ErrorHelper
  include TimeHelper
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
