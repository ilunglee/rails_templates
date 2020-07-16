# frozen_string_literal: true

def source_paths
  [__dir__]
end

rspec = yes?('Generate RSpec files?')

if yes?('Install EmailFormatValidator?')
  template './templates/app/validators/email_format_validator.rb', 'app/validators/email_format_validator.rb'

  rspec &&
    template('./templates/spec/shared/validators/email_format_validator.rb', 'spec/shared/validators/email_format_validator.rb')
end

if yes?('Install ZipCodeFormatValidator?')
  template './templates/app/validators/zip_code_format_validator.rb', 'app/validators/zip_code_format_validator.rb'

  rspec &&
    template('./templates/spec/shared/validators/zip_code_format_validator.rb', 'spec/shared/validators/zip_code_format_validator.rb')
end

if yes?('Install PhoneFormatValidator?')
  template './templates/app/validators/phone_format_validator.rb', 'app/validators/phone_format_validator.rb'

  rspec &&
    template('./templates/spec/shared/validators/phone_format_validator.rb', 'spec/shared/validators/phone_format_validator.rb')
end
