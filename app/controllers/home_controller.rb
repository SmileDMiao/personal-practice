# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @node_count = Node.all.count
    @articles = Article.popular.includes(:user, :node).limit(20)
    fresh_when([@articles, @node_count])
  end
end
