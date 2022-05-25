class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        remember @user
        redirect_back_or welcome_dashboard_path
      else
        flash[:warning] = "Account not activated; check your email for the activation link."
        redirect_to root_url
      end
    else
      flash.now[:error] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
