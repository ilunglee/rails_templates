Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'] || Rails.application.credentials.dig(Rails.env.to_sym, :stripe, :publishable_key),
  secret_key: ENV['STRIPE_SECRET_KEY'] || Rails.application.credentials.dig(Rails.env.to_sym, :stripe, :secret_key),
  statement_descriptor: ENV['STRIPE_STATEMENT_DESCRIPTOR'],
  version: '2020-03-02'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_version = Rails.configuration.stripe[:version]
