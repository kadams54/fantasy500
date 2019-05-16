class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = "Please log in to access this page."
      redirect_to login_url
    end
  end

  def admin_user
    render plain: "403 Forbidden", status: :forbidden unless current_user.admin?
  end
end
