# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    # elasticsearch query dsl
    search_params = {
      query: {
        simple_query_string: {
          query: params[:search],
          default_operator: "AND",
          minimum_should_match: "70%",
          fields: %w[title body]
        }
      },
      highlight: {
        pre_tags: ["<em>"],
        post_tags: ["</em>"],
        fields: {title: {}, body: {}}
      }
    }
    @result = Elasticsearch::Model.search(search_params, [Article]).page(params[:page])
  end
end
