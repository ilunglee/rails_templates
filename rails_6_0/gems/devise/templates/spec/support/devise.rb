require_relative 'controller/macros'
require 'devise'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.extend Controller::Macros, type: :controller

  config.before :suite do
    Warden.test_mode!
  end
end
