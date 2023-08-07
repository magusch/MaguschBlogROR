class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  def show
    authorize! :read, @post, message: "You need to be signed-in to do that."

  end

  def index
    @pages = Page.all
  end

  def new
    @pages = Page.new
  end

  def create
    @pages = Page.new(page_params)

    if @pages.save
      flash[:success] = "Page was successfully created"
      redirect_to @pages
    else
      render :new, status: :unprocessable_entity
    end
  end

  def change_navbar_display
    @page = Page.find(params[:id])
    @page.toggle(:navbar_display).save
    redirect_to page_path(@page)
  end

  private
  def page_params
    params.require(:page).permit(:page_name, :page_text, :navbar_display)
  end

  def set_page
    @page = Page.find(params[:id])
  end
end
