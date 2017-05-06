class SearchController < ApplicationController

  def index
    # @result = PgSearch.multisearch(params[:search]).with_pg_search_highlight
    redirect_to :back
  end

  # def index
  #   #elasticsearch query dsl
  #   search_params = {
  #       query: {
  #           simple_query_string: {
  #               query: params[:search],
  #               default_operator: 'AND',
  #               minimum_should_match: '70%',
  #               fields: %w(title body full_name)
  #           }
  #       },
  #       highlight: {
  #           pre_tags: ['[em]'],
  #           post_tags: ['[/em]'],
  #           fields: { title: {}, body: {}, name: {}, full_name: {} }
  #       }
  #   }
  #   @result = Elasticsearch::Model.search(search_params, [Article, User])
  #   binding.pry
  # end

end