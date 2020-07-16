# frozen_string_literal: true

run 'spring stop'

gem_group :development do
  # Generate ERD
  gem 'rails-erd'
end

run 'bundle install'
run 'bundle exec rails g erd:install'

def source_paths
  [__dir__]
end

template './templates/.erdconfig', '.erdconfig'
