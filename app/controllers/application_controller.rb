class ApplicationController < ActionController::Base
  before_action :set_pages

  private

  def set_pages
    @pages_navbar = Page.where(navbar_display: true)
  end
end
