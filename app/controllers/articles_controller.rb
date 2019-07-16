class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    json_response @articles
  end

  def create
    @article = Article.create!(article_params)
    json_response @article, :created
  end

  def article_params
    params.permit(:title,:text)
  end
end
