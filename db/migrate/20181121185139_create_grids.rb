class CreateGrids < ActiveRecord::Migration[5.2]
  def change
    create_table :grids do |t|
      t.integer :lap

      t.timestamps
    end
  end
end
