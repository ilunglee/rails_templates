module HasOneAvatar

  extend ActiveSupport::Concern

  FORMATS = %w[jpg jpeg png gif].freeze

  included do
    attribute :remove_avatar, :boolean, default: false

    has_one_attached :avatar
    validates :avatar, content_type: FORMATS.map { |x| "image/#{x}" },
                       size: { less_than: 5.megabytes }
    before_save :purge_avatar, if: :remove_avatar
  end

  class_methods do
    def avatar_attrs
      %i[avatar remove_avatar]
    end
  end

  def thumbnail
    return unless avatar.attached? && avatar.variable?

    avatar.variant(resize: '64x64')
  end

  private

  def purge_avatar
    return unless avatar.attached?

    avatar.purge
  end

end
