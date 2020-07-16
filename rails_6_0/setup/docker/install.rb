# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/.dockerignore', '.dockerignore'
template './templates/Dockerfile', 'Dockerfile'
template './templates/docker-compose.yml', 'docker-compose.yml'
template './templates/docs/docker.md', 'docs/docker.md'

# For Docker build error
environment 'config.webpacker.check_yarn_integrity = false', env: 'development'
