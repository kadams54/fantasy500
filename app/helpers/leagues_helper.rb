module LeaguesHelper
  def league_member?(league)
    leagues = current_user.teams.map(&:leagues).flatten.uniq
    leagues.include?(league) 
  end
end
