# frozen_string_literal: true

run 'spring stop'

# **** INSTALL GEMS ****
# Use Faker to create fake data
gem 'faker', '~> 2.11'
# Use FactoryBot to generate fake data
gem 'factory_bot_rails'

gem_group :development do
  # Rubocop gems
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rubocop-rails'
end

gem_group :test do
  # Validation
  gem 'shoulda-matchers', '~> 3.0', require: false
  # Use RSpec as Testing Framework
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0.0.beta2'
  # Retry random failed tests
  gem 'rspec-retry'
  # Browser testing
  gem 'capybara'
  # gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.0'
  # Record RSpec as video
  gem 'screen-recorder', '~> 1.0'
  gem 'database_cleaner', '~> 1.6.2'
  # Spec Converage
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'simplecov-small-badge', require: false
  # API Tests
  gem 'webmock'
  gem 'vcr'
  # Session Access
  gem 'rack_session_access'
end

run 'bundle install'
rails_command 'generate rspec:install'
run 'rm -rf test' if yes?('Do you want to remove the /test directory?')

def source_paths
  [__dir__]
end

# **** COPY FILES ****
template './templates/.rspec', '.rspec'
template './templates/spec/rails_helper.rb', 'spec/rails_helper.rb'
template './templates/spec/support/database_cleaner.rb', 'spec/support/database_cleaner.rb'
template './templates/spec/support/active_job.rb', 'spec/support/active_job.rb'
template './templates/spec/support/factory_bot.rb', 'spec/support/factory_bot.rb'
template './templates/spec/support/rspec_retry.rb', 'spec/support/rspec_retry.rb'
template './templates/spec/support/shoulda_matchers.rb', 'spec/support/shoulda_matchers.rb'
template './templates/spec/support/vcr.rb', 'spec/support/vcr.rb'
template './templates/spec/support/wait_for_ajax.rb', 'spec/support/wait_for_ajax.rb'
template './templates/docs/rspec.md', 'docs/rspec.md'

if yes?('Install capybara Stripe helpers?')
  template './templates/spec/support/capybara/stripe.rb', 'spec/support/capybara/stripe.rb'
end

if yes?('Install capybara live browsing and screen recording helpers?')
  template './templates/spec/support/capybara.rb', 'spec/support/capybara.rb'

  append_to_file 'docs/rspec.md', <<~CODE
    If you want to run testing with live browser. Update your environment variables inside `.env.test`. To write integration/feature tests you can use [Capycorder] to record to get sample scripts. Please note the sample scripts are not formatted properly so you will need to adjust the scripts yourself.
    - You must have Chrome Browser installed.
    - Set `SPEC_LIVE_BROWSING` to `true` to open brower during testing.
    - Set `SPEC_LIVE_BROWSING` and `SPEC_LIVE_SREENSHOT` to `true` to capture screenshots.
    - Set `SPEC_LIVE_BROWSING` and `SPEC_LIVE_RECORDING` to `true` to capture recordings.
    - Set `SPEC_LIVE_BROWSING_SLEEP` to an `integer` in seconds to adjust the page speed.

  CODE
end

if yes?('Install SimpleCov?')
  gem_group :test do
    # Spec Converage
    gem 'simplecov', require: false
    gem 'simplecov-console', require: false
    gem 'simplecov-small-badge', require: false
  end

  run 'bundle install'

  inject_into_file 'spec/spec_helper.rb', before: "RSpec.configure do |config|\n" do
    <<~CODE
      require 'simplecov'
      require 'simplecov-console'
      require 'simplecov_small_badge'

      SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
        [
          SimpleCov::Formatter::HTMLFormatter,
          SimpleCov::Formatter::Console,
          SimpleCovSmallBadge::Formatter
        ]
      )
      SimpleCov.start do
        coverage_dir Rails.root.join('tmp', 'reports', 'coverage')

        add_filter %r{^/app/(uploaders | helpers)/}
        add_filter 'spec'
        add_filter 'config'
        add_filter 'app/decorators'
        add_filter 'app/admin/concerns'

        add_group 'Controllers', 'app/controllers'
        add_group 'Models', 'app/models'
        add_group 'Services', 'app/services'
        add_group 'Helpers', 'app/helpers'
        add_group 'Admin', 'app/admin'
      end

      SimpleCovSmallBadge.configure do |config|
        config.output_path = Rails.root.join('badges')
      end

    CODE
  end
end

if yes?('Install i18n-tasks as well?')
  gem_group :development, :test do
    # Find unused I18n keys
    gem 'i18n-tasks', '~> 0.9.21'
  end

  run 'bundle install'
  run 'cp $(i18n-tasks gem-path)/templates/config/i18n-tasks.yml config/'
  run 'cp $(i18n-tasks gem-path)/templates/rspec/i18n_spec.rb spec/'
end
