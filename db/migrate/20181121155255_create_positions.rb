class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.integer :place
      t.integer :lap
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
