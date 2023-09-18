class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action -> { check_authenticate_for_edit(@article) }, only: [:new, :create, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was deleted"
    redirect_to articles_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status, :user_id, :image)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
