# frozen_string_literal: true

run 'spring stop'

# Use dotenv to manage environment variables
gem 'dotenv-rails', groups: %i[development test], require: 'dotenv/rails-now'

run 'bundle install'
