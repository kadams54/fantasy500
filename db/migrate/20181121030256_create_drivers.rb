class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :number
      t.string :team
      t.string :make_model

      t.timestamps
    end
  end
end
