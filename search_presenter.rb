
class SearchPresenter
  attr_reader :search

  def initialize(search)
    @search = search
  end

  delegate_missing_to :search

  def first_item_in_page_count
    assumed_last_item_in_page_count - per_page + 1
  end

  def last_item_in_page_count
    assumed_last_item_in_page_count < total_count ? assumed_last_item_in_page_count : total_count
  end

  def has_previous_page?
    page > 1
  end

  def path_to_previous_page
   search_path_with_page(page-1)
  end

  def has_next_page?
    total_count - assumed_last_item_in_page_count > 0
  end

  def path_to_next_page
    search_path_with_page(page+1)
  end

  private

  def assumed_last_item_in_page_count
    page * per_page
  end

  def search_path_with_page(page)
    search_path + "&page=#{page}"
  end

  def search_path
    "/search?query=#{query}"
  end
end