class AddYearToIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :drivers, :number
    add_index :drivers, [:number, :year], unique: true
    remove_index :grids, :lap
    add_index :grids, [:lap, :year], unique: true
  end
end
