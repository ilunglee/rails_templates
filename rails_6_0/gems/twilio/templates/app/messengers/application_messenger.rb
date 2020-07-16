# Application Messenger
class ApplicationMessenger

  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TranslationHelper
  include ActionView::Helpers::NumberHelper
  include FormatHelper
  extend Callable

  attr_accessor :response

  def default_url_options
    { host: Rails.configuration.domain }
  end

  def locale
    @locale ||= Rails.configuration.i18n.default_locale
  end

  def client
    @client ||=
      Twilio::REST::Client.new(Rails.configuration.twilio[:account_sid],
                              Rails.configuration.twilio[:auth_token])
  end

  def sms(to:, body:, from: Rails.configuration.twilio[:phone_number])
    return if to.blank?

    self.response = client.messages.create(from: "+#\{from\}", to: "+#\{send_to(to)\}", body: body)
  end

  def send_to(phone_number)
    Rails.configuration.twilio[:test_phone_number] || phone_number
  end

  def with_locale
    I18n.with_locale(locale) do
      yield
    end
  end

  def render(template, locals = {})
    ApplicationController.render(template, assigns: locals, layout: 'mailer', formats: %i[text])
  end

end
