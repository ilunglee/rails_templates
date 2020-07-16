# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/.sass-lint.yml', '.sass-lint.yml'
template './templates/.slim-lint.yml', '.slim-lint.yml'
template './templates/.rubocop.yml', '.rubocop.yml'
