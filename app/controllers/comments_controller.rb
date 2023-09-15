class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:archive, :destroy]

  def index
    @article = Article.find(params[:article_id])
  end

  def create
    @article = Article.find(params[:article_id])
    if @article.comments.count >= 100
      flash[:success] = "It has to much comments"
      redirect_to article_path(@article)
    else
      @comment = @article.comments.create(comment_params)
      @comment.save
      redirect_to article_path(@article)
    end


    #redirect_to article_path(@article)

      #turbo_stream.append "comment-form", partial: 'comments/comment', locals: { comment: @comment }
      #render turbo_stream: turbo_stream.replace("comments-list", partial: 'comments/comment', collection: @article.comments)
    # else
    #   render :new
    # end
  end

  def archive
    @comment = Comment.find(params[:id])
    @comment.status = 'archived'
    @comment.save
    redirect_to article_path(@comment.article)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = @comment.article

    @comment.destroy
    flash[:success] = "Comment was deleted"
    redirect_to article_path(@article), status: :see_other
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @article = @comment.article
    if @comment.update(comment_params)
      flash[:success] = "Comment was successfully updated"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
