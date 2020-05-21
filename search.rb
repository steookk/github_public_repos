require_relative 'github'

class Search < Github
  attr_reader :query, :per_page, :page

  class << self
    def call(query:, per_page:, page:)
      begin
        response = client.search_repos(query, per_page: per_page, page: page)
        Success.new(query: query, per_page: per_page, page: page, total_count: response.total_count, items: define_items(response.items))

      rescue Octokit::UnprocessableEntity => e
        Failure.new(query: query, per_page: per_page, page: page, message: e.message)
      end
    end  

    private

    # override `items` in order to exclusively expose data needed by the application - *see README* for extensive explanation.
    def define_items(items)
      items.map { |item| {html_url: item.html_url, full_name: item.full_name }}
    end

  end

  def initialize(query:, per_page:, page:)
    @query, @per_page, @page = query, per_page, page
  end

  class Success < Search
    attr_reader :total_count, :items

    def initialize(total_count:, items:, **args)
      @total_count, @items = total_count, items
      super(**args)
    end

    def success?
      true
    end

    def failure?
      false
    end
  end

  class Failure < Search
    attr_reader :message

    def initialize(message:, **args)
      @message = message
      super(**args)
    end

    def success?
      false
    end

    def failure?
      true
    end
  end
end
