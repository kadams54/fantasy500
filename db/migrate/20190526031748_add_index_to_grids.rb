class AddIndexToGrids < ActiveRecord::Migration[5.2]
  def change
    add_index :grids, :lap, unique: true
  end
end
