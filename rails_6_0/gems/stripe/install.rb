# frozen_string_literal: true

run 'spring stop'

# Use Stripe for payment
gem 'stripe'

run 'bundle install'

def source_paths
  [__dir__]
end

template './templates/config/initializers/credentials/stripe.rb', 'config/initializers/credentials/stripe.rb'
template './templates/app/assets/javascripts/lib/stripe_element.coffee', 'app/assets/javascripts/lib/stripe_element.coffee'
template './templates/app/models/concerns/stripe/has_one_customer.rb', 'app/models/concerns/stripe/has_one_customer.rb'
template './templates/app/services/stripe_customer_associator.rb', 'app/services/stripe_customer_associator.rb'
template './templates/app/services/stripe_api/charge/create.rb', 'app/services/stripe_api/charge/create.rb'
template './templates/app/services/stripe_api/customer/create.rb', 'app/services/stripe_api/customer/create.rb'
template './templates/app/services/stripe_api/customer/find_or_create.rb', 'app/services/stripe_api/customer/find_or_create.rb'
template './templates/app/services/stripe_api/customer/find.rb', 'app/services/stripe_api/customer/find.rb'
template './templates/app/services/stripe_api/source/base.rb', 'app/services/stripe_api/source/base.rb'
template './templates/app/services/stripe_api/source/create.rb', 'app/services/stripe_api/source/create.rb'
template './templates/app/services/stripe_api/source/find_or_create.rb', 'app/services/stripe_api/source/find_or_create.rb'
template './templates/app/services/stripe_api/source/find.rb', 'app/services/stripe_api/source/find.rb'

if yes?('Generate spec files?')
  template './templates/spec/services/stripe_api/charge/create_spec.rb', 'spec/services/stripe_api/charge/create_spec.rb'
  template './templates/spec/services/stripe_api/customer/create_spec.rb', 'spec/services/stripe_api/customer/create_spec.rb'
  template './templates/spec/services/stripe_api/customer/find_or_create_spec.rb', 'spec/services/stripe_api/customer/find_or_create_spec.rb'
  template './templates/spec/services/stripe_api/customer/find_spec.rb', 'spec/services/stripe_api/customer/find_spec.rb'
  template './templates/spec/services/stripe_api/source/create_spec.rb', 'spec/services/stripe_api/source/create_spec.rb'
  template './templates/spec/services/stripe_api/source/find_spec.rb', 'spec/services/stripe_api/source/find_spec.rb'
  template './templates/spec/shared/models/concerns/stripe/has_one_customer.rb', 'spec/shared/models/concerns/stripe/has_one_customer.rb'
end
