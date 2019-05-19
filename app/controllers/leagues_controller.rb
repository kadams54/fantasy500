class LeaguesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @leagues = League.all
  end

  def show
    @league = League.find(params[:id])
  end

  def new
    @league = League.new
  end

  def edit
    @league = League.find(params[:id])
  end

  def create
    @league = current_user.leagues.create(league_params)
    @league.teams << current_user.team

    if @league.save
      redirect_to @league
    else
      render "new"
    end
  end

  def update
    @league = League.find(params[:id])

    if @league.update(league_params)
      redirect_to @league
    else
      render "edit"
    end
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy

    redirect_to welcome_dashboard_path
  end

  private

  def league_params
    params.require(:league).permit(:name, :password, :password_confirmation)
  end

  def correct_user
    @league = League.find(params[:id])
    render plain: "403 Forbidden", status: :forbidden unless current_user?(@league.commish)
  end
end
