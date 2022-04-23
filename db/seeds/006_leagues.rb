League.destroy_all

commish = User.find_by(email: "commish@example.com")

league = League.create!(
  commish: commish,
  name: "Commish League",
)

commish.teams.first.leagues << league
