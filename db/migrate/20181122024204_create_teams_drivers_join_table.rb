class CreateTeamsDriversJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :drivers, :teams do |t|
      t.index :driver_id
      t.index :team_id
    end
  end
end
