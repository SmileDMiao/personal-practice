class SearchController < ApplicationController

  def index
    @result = PgSearch.multisearch(params[:search]).with_pg_search_highlight
  end

end