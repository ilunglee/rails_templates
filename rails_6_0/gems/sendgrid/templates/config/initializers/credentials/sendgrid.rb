Rails.configuration.sendgrid = {
  api_key: Rails.application.credentials.dig(Rails.env.to_sym, :sendgrid, :api_key),
  domain: Rails.configuration.domain,
  notification_email: ENV['NOTIFICATION_EMAIL'],
  sender_email: 'noreply@youroddsare.com',
  reply_to_email: ENV['REPLY_TO_EMAIL']
}
