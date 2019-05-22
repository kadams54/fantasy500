class WelcomeController < ApplicationController
  before_action :logged_in_user, only: [:dashboard]

  def index
    if logged_in?
      redirect_to :welcome_dashboard
    end
  end

  def dashboard
    @team = current_user.team
  end
end
