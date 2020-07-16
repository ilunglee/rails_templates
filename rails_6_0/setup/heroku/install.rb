# frozen_string_literal: true

def source_paths
  [__dir__]
end

@name = ask("What's the app name?")
@description = ask("What's the app description?")

template './templates/app.json.erb', 'app.json'
template './templates/Procfile', 'Procfile'
