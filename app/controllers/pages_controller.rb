class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_page, only: [:show, :edit, :update, :destroy, :change_navbar_display]
  before_action -> { check_authenticate_for_edit(@page) }, only: [:new, :create, :edit, :update, :destroy]
  def show
  end

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      flash[:success] = "Page was successfully created"
      redirect_to @page
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @page.destroy
    flash[:success] = "Page was deleted"
    redirect_to pages_path, status: :see_other
  end

  def edit
  end

  def update
    if @page.update(page_params)
      flash[:success] = "Article was successfully updated"
      redirect_to @page
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def change_navbar_display
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
