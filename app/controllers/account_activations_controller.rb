class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Welcome to the Fantasy 500!"
      redirect_to welcome_dashboard_path
    else
      flash[:danger] = "Invalid activation link."
      redirect_to root_url
    end
  end
end
