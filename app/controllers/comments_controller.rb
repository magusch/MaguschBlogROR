class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:archive, :destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def archive
    @comment = Comment.find(params[:id])
    @comment.status = 'archived'
    @comment.save
    redirect_to article_path(@comment.article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
