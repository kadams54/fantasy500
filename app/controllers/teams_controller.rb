class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :new, :create]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :admin_user,     only: [:index]

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = current_user.create_team(team_params)

    if @team.save
      redirect_to @team
    else
      render "new"
    end
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to @team
    else
      render "edit"
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, {driver_ids: []})
  end

  def correct_user
    @team = Team.find(params[:id])
    render plain: "403 Forbidden", status: :forbidden unless current_user?(@team.user)
  end
end
