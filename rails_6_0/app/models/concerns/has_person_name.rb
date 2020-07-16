# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/app/models/concerns/has_person_name.rb', 'app/models/concerns/has_person_name.rb'
