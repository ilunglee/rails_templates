ActiveSupport.on_load(:action_text_rich_text) do
  ActionText::RichText.class_eval do
    before_save :create_version

    private

    def create_version
      return unless body_changed?
      return if name == 'body' && record_type == 'ActionTextVersion'

      if record.respond_to?(:action_text_versions) &&
         record.try(:auto_create_action_text_versions?)
        ActionTextVersion.create(resource: record, body: body_was, author: CurrentScope.user)
      end
    end
  end
end
