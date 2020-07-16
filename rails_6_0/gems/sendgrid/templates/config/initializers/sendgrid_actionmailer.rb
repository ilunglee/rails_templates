if Rails.env.production?
  ActionMailer::Base.delivery_method = :sendgrid_actionmailer
  ActionMailer::Base.default_url_options = { host: ENV['DOMAIN'] }
  ActionMailer::Base.asset_host = ENV['DOMAIN']
  ActionMailer::Base.sendgrid_actionmailer_settings = {
    api_key: Rails.configuration.sendgrid[:api_key],
    raise_delivery_errors: true
  }
end
