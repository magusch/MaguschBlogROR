class ApplicationController < ActionController::Base
  before_action :set_pages


  rescue_from CanCan::AccessDenied do |exception|
    flash[:success] = "Access denied. You are not authorized to perform this action."
    redirect_to root_url # or any other path
  end

  private

  def set_pages
    @pages_navbar = Page.where(navbar_display: true).limit(5)
    @pages_footer = Page.where(navbar_display: true).limit(3) # add footer_display to pages table
  end

  def check_authenticate_for_edit(object)
    authorize! :edit, object
  end
end
