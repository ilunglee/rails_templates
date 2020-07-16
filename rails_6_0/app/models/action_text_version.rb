# frozen_string_literal: true

def source_paths
  [__dir__]
end

run 'spring stop'

generate 'model action_text_version author:references{polymorphic} resource:references{polymorphic}'
rails_command 'db:migrate'

template './templates/app/models/current_scope.rb', 'app/models/current_scope.rb'
template './templates/app/models/action_text_version.rb', 'app/models/action_text_version.rb'
template './templates/app/models/concerns/has_many_action_text_versions.rb', 'app/models/concerns/has_many_action_text_versions.rb'
template './templates/config/initializers/action_text_version.rb', 'config/initializers/action_text_version.rb'

text = <<~RUBY
  ###############################################################
  ###############################################################
  ###############################################################
  # To record author for changes Add this to your controller code
  around_action :user_for_version

  private

  def user_for_version
    CurrentScope.user = current_admin_user
    yield
  end
RUBY

puts text
