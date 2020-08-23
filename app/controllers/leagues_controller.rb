class LeaguesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @leagues = League.current.all
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
    if @league.save
      @league.teams << current_user.team
      @league.send_membership_emails(invites)
      flash[:success] = "Thank you for creating a league!"
      redirect_to @league
    else
      render "new"
    end
  end

  def update
    @league = League.find(params[:id])

    if @league.update(league_params)
      @league.send_membership_emails(invites)
      flash[:success] = "We have updated your league."
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

  def invites
    invites_params.split(/\s*,\s*/)
  end

  def league_params
    params.require(:league).permit(:name)
  end

  def invites_params
    params.require(:league).permit(:invites)
  end

  def correct_user
    @league = League.find(params[:id])
    render plain: "403 Forbidden", status: :forbidden unless current_user?(@league.commish)
  end
end
