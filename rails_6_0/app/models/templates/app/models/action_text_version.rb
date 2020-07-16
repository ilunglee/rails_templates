class ActionTextVersion < ApplicationRecord

  belongs_to :author, polymorphic: true, optional: false
  belongs_to :resource, polymorphic: true, optional: false

  has_rich_text :body

end
