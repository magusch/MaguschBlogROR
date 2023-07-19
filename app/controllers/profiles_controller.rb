class ProfilesController < ApplicationController
  def show
    @user = current_user # Assuming you are using Devise for authentication
  end
end
