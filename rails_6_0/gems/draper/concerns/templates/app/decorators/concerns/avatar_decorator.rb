# Decorates Avatar
module AvatarDecorator

  def avatar_with_name(name = 'display_name')
    avatar(css_class: 'sm rounded-circle mr-2 d-inline-block align-middle') +
      content_tag(:span, object.try(name), class: 'name align-middle')
  end

  def avatar(*args)
    options = args.extract_options!
    if object.thumbnail
      thumbnail_tag object.thumbnail, options
    else
      thumbnail_tag object.initial, options.merge(image: false)
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def thumbnail_tag(content, css_class: nil, image: true)
    if image
      content_tag(
        :div, '',
        class: "thumbnail #{css_class}".strip,
        style: "background-image: url('#{rails_representation_url(content, only_path: true)}')"
      )
    else
      content_tag :div, class: "thumbnail alert-warning font-weight-bold #{css_class}".strip do
        content
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

end
