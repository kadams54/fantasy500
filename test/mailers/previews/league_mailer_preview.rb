# Preview all emails at http://localhost:3000/rails/mailers/league_mailer
class LeagueMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/league_mailer/mambership
  def mambership
    LeagueMailer.mambership
  end

end
