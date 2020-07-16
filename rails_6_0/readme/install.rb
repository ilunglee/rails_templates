# frozen_string_literal: true

def source_paths
  [__dir__]
end

@name = ask('What is the name of the project?')
template './templates/README.md.erb', 'README.md'
