if Rails.env.production? && Rails.configuration.sentry[:dsn].present?
  Raven.configure do |config|
    config.dsn = Rails.configuration.sentry[:dsn]
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
    config.environments = %w[production]
    config.excluded_exceptions += ['ActionController::RoutingError', 'ActiveRecord::RecordNotFound']
    config.async = ->(event) { SentryJob.perform_later(event) }
  end
end
