class LeagueMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.league_mailer.membership.subject
  #
  def membership(email, league)
    @league = league
    mail to: email, subject: "[Fantasy 500] League Membership"
  end
end
