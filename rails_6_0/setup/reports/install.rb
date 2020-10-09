# frozen_string_literal: true

run 'spring stop'

def source_paths
  [__dir__]
end

if yes?('Install Yard?')
  gem_group :development do
    # For documentation
    gem 'yard'
  end

  template './templates/.yardopts', '.yardopts'
end

if yes?('Install Inch?')
  gem_group :development do
    # Measure documentation stats
    gem 'inch', require: false
  end
end

if yes?('Install Brakeman?')
  gem_group :development do
    # Check for security
    gem 'brakeman'
  end

  template './templates/config/brakeman.yml', 'config/brakeman.yml'
end

if yes?('Install License Finder?')
  gem_group :development do
    # List out all dependencies licenses
    gem 'license_finder'
  end

  template './templates/config/license_finder.yml', 'config/license_finder.yml'
  template './templates/config/dependency_decisions.yml', 'config/dependency_decisions.yml'
end

run 'bundle install'
