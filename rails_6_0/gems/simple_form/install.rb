# frozen_string_literal: true

run 'spring stop'

# Use Simple Form for extended form builder
gem 'simple_form'

unless yes?('Install Boostrap already?')
  # Use Bootstrap as the CSS framework
  gem 'bootstrap', '>= 4.3'
end

run 'bundle install'

def source_paths
  [__dir__]
end

template './templates/config/initializers/simple_form.rb', 'config/initializers/simple_form.rb'
template './templates/config/initializers/simple_form_bootstrap.rb', 'config/initializers/simple_form_bootstrap.rb'
template './templates/app/inputs/toggle_input.rb', 'app/inputs/toggle_input.rb'
