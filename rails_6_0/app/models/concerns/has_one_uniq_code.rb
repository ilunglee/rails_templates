# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/app/models/concerns/has_one_uniq_code.rb', 'app/models/concerns/has_one_uniq_code.rb'
