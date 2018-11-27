class WelcomeController < ApplicationController
  def index
    @teams = Team.all
  end
end
