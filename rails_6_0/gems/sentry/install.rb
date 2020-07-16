# frozen_string_literal: true

run 'spring stop'

gem_group :production do
  # Use Sentry for error monitoring
  gem 'sentry-raven'
end

run 'bundle install'

def source_paths
  [__dir__]
end

template './templates/config/initializers/sentry.rb', 'config/initializers/sentry.rb'
template './templates/config/initializers/credentials/sentry.rb', 'config/initializers/credentials/sentry.rb'
template './templates/app/jobs/sentry_job.rb', 'app/jobs/sentry_job.rb'
