require_relative '../config/environment'
require 'spec_helper'
require 'mock_redis'
require 'capybara/rspec'
require 'rspec/rails'

# Automatically require all files in the `spec/support` directory
Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

ENV['RAILS_ENV'] ||= 'test'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
	# Test formatting
	config.formatter = :documentation

	# Include the WaitHelper module
  config.include WaitHelper

	# Include the RedisHelper module
	config.include RedisHelper

	# Include ActiveSupport testing time helpers
  config.include ActiveSupport::Testing::TimeHelpers

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_paths = [
  #   Rails.root.join('spec/fixtures')
  # ]

	# Simulate Redis interactions in tests without requiring an actual Redis server. 
	config.before(:each) do
    # Replace the Redis instance with MockRedis
    allow(Redis).to receive(:new).and_return(MockRedis.new)
  end

	# Set Capybara default max wait time
  Capybara.default_max_wait_time = 5 # seconds

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

	config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

	config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
