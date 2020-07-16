# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/app/helpers/format_helper.rb', 'app/helpers/format_helper.rb'
