Team.destroy_all

commish = User.find_by(email: "commish@example.com")
commish.teams.create!(name: "Commish Team")
commish.teams.first.drivers << Driver.all.sample(5)
