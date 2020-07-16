module HasManyActionTextVersions

  extend ActiveSupport::Concern

  included do
    has_many :action_text_versions, as: :resource, dependent: :destroy
  end

  def auto_create_action_text_versions?
    true
  end

end
