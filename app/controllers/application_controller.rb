class ApplicationController < ActionController::Base
  before_action :set_pages

  private

  def set_pages
    @pages_navbar = Page.where(navbar_display: true).limit(5)
    @pages_footer = Page.where(navbar_display: true).limit(3) # add footer_display to pages table
  end
end
