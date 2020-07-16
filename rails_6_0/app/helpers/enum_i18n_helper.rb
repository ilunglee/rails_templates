# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/app/helpers/enum_i18n_helper.rb', 'app/helpers/enum_i18n_helper.rb'
