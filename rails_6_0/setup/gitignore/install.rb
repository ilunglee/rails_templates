# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/.gitignore', '.gitignore'
