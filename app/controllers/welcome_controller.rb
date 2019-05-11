class WelcomeController < ApplicationController
  def index
    if logged_in?
      redirect_to :welcome_dashboard
    end
  end

  def dashboard
    @team = current_user.team
  end
end
