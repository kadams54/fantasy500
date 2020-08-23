class LeagueMembershipsController < ApplicationController
  before_action :logged_in_user, only: [:edit]

  def edit
    league = League.find(params[:league_id])
    if league && league.authenticated?(:membership, params[:id])
      league.teams << current_user.teams.current.first
      flash[:success] = "Welcome to the #{league.name} league!"
    else
      flash[:danger] = "Invalid league membership link."
    end
    redirect_to welcome_dashboard_path
  end
end
