# frozen_string_literal: true

run 'spring stop'

# Draper as decorator - Using 3.0.0.pre1 for Rails 5 compatibility issue
gem 'draper', '~> 3.1.0'

run 'bundle install'

def source_paths
  [__dir__]
end

template './templates/app/decorators/application_decorator.rb', 'app/decorators/application_decorator.rb'
template './templates/app/decorators/paginating_decorator.rb', 'app/decorators/paginating_decorator.rb'
