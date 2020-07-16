# frozen_string_literal: true

run 'spring stop'

gem 'devise'

run 'bundle install'

def source_paths
  [__dir__]
end

if yes?('Install RSpec helpers?')
  template './templates/spec/support/controller/macros.rb', 'spec/support/controller/macros.rb'
  template './templates/spec/support/devise.rb', 'spec/support/devise.rb'
end
