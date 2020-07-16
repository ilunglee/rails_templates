def source_paths
  [__dir__]
end

template './templates/lib/tasks/seed.rake', 'lib/tasks/seed.rake'
