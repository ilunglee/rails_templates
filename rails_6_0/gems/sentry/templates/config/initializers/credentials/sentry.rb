Rails.configuration.sentry = {
  dsn: Rails.application.credentials.dig(Rails.env.to_sym, :sentry, :dsn)
}
