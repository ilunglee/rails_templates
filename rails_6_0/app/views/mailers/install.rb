# frozen_string_literal: true

def source_paths
  [__dir__]
end

template './templates/app/views/layouts/mailer.html.erb', 'app/views/layouts/mailer.html.erb'
template './templates/app/views/layouts/mailer.text.erb', 'app/views/layouts/mailer.text.erb'
template './templates/app/views/mailer/_footer.html.erb', 'app/views/mailer/_footer.html.erb'
template './templates/app/views/mailer/_signature.html.erb', 'app/views/mailer/_signature.html.erb'
