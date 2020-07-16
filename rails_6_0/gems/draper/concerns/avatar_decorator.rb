# frozen_string_literal: true

run 'spring stop'

# Validates ActiveStorage uploads
gem 'active_storage_validations'

run 'bundle install'

def source_paths
  [__dir__]
end

template './templates/app/decorators/concerns/avatar_decorator.rb',
         'app/decorators/concerns/avatar_decorator.rb'
