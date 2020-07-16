# Pagination Patch
class PaginatingDecorator < Draper::CollectionDecorator

  # support for pagination - will_paginate & kaminari
  delegate :current_page, :per_page, :offset, :total_entries,
           :total_pages, :per_page_kaminari

end
