# frozen_string_literal: true

run 'spring stop'

# Twilio SMS
gem 'twilio-ruby', '~> 5.18.0'

run 'bundle install'

def source_paths
  [__dir__]
end

template './templates/config/initializers/credentials/twilio.rb', 'config/initializers/credentials/twilio.rb'
template './templates/app/messengers/application_messenger.rb', 'app/messengers/application_messenger.rb'
