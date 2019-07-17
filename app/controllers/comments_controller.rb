class CommentsController < ApplicationController
  skip_before_action :authorize_request
  before_action :set_article
  before_action :set_comment, only: [:update, :destroy]

  def index
    @comments = @article.comments
    
    json_response(@comments)
  end

  def create
    @comment = @article.comments.create! comment_params
    
    json_response(@comment, :created)
  end

  def update
    @comment.update comment_params

    head :no_content
  end

  def destroy
    @comment.destroy

    head :no_content
  end
  
  private
    def set_article
      @article = Article.find(params[:article_id])
    end 

    def set_comment
      @comment = @article.comments.find_by!(id: params[:id]) if @article
    end

    def comment_params
      params.permit(:body)
    end
end
