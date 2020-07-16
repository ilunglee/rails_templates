Rails.configuration.twilio = {
  account_sid: Rails.application.credentials.dig(Rails.env.to_sym, :twilio, :account_sid),
  auth_token: Rails.application.credentials.dig(Rails.env.to_sym, :twilio, :auth_token),
  phone_number: ENV['TWILIO_PHONE_NUMBER'] || '15005550006',
  test_phone_number: ENV['TWILIO_TEST_PHONE_NUMBER']
}
