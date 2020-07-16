# frozen_string_literal: true

run 'spring stop'

gem_group :production do
  # Use Skylight for performance monitoring
  gem 'skylight'
end

run 'bundle install'

apikey = ask('What is your Skylight project API key?')
run "bundle exec skylight setup #{apikey}"
