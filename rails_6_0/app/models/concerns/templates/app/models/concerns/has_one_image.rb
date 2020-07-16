module HasOneImage

  extend ActiveSupport::Concern

  FORMATS = %w[jpg jpeg png gif].freeze

  included do
    attribute :remove_image, :boolean, default: false

    has_one_attached :image
    validates :image, content_type: FORMATS.map { |x| "image/#{x}" },
                      size: { less_than: 5.megabytes }
    before_save :purge_image, if: :remove_image
  end

  class_methods do
    def image_attrs
      %i[image remove_image]
    end
  end

  def image_size(size = nil)
    size ||= '64x64'
    return unless image.attached? && image.variable?

    image.variant(resize: size)
  end

  def thumbnail
    image_size('64x64')
  end

  private

  def purge_image
    return unless image.attached?

    image.purge
  end

end
