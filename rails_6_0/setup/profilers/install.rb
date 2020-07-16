# frozen_string_literal: true

run 'spring stop'

gem_group :development do
  # Rails Chrome Panel
  gem 'meta_request'
  # Profiles Queries
  gem 'rack-mini-profiler'
  # For call-stack profiling flamegraphs
  gem 'flamegraph'
  gem 'stackprof'
  gem 'memory_profiler'
end

run 'bundle install'
