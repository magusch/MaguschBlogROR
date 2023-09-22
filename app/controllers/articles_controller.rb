class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action -> { check_authenticate_for_edit(@article) }, only: [:new, :create, :edit, :update, :destroy]
  include ArticlesHelper
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
    authorize! :read, @article
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

    images_to_delete = params[:article][:images_to_delete]

    if images_to_delete.present?
      # Detach the selected images from the article
      @article.images.where(id: images_to_delete).purge
    end


    if @article.update(article_params)
      if params[:article][:images].present?
        @article.images.attach(params[:article][:images])
      end
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

  def markdown_to_html
    input_text = params[:input_text]
    images = params[:images_data] || []
    html_text = prepare_article(input_text, images)
    render json: { html_text: html_text }
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status, :user_id, :page)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
