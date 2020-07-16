# frozen_string_literal: true

run 'spring stop'

# User SendGrid for ActionMailer
gem 'sendgrid-actionmailer'

gem_group :development, :test do
  # Use Letter Opener to debug email on development
  gem 'letter_opener'
end

run 'bundle install'

environment 'config.action_mailer.delivery_method = :letter_opener', env: 'development'

if yes?('Generate RSpec files?')
  environment "config.action_mailer.preview_path = Rails.root.join('spec', 'mailers', 'previews')", env: 'development'
end

def source_paths
  [__dir__]
end

template './templates/config/initializers/sendgrid_actionmailer.rb', 'config/initializers/sendgrid_actionmailer.rb'
template './templates/config/initializers/credentials/sendgrid.rb', 'config/initializers/credentials/sendgrid.rb'
