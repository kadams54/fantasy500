class AddGridToPositions < ActiveRecord::Migration[5.2]
  def change
    add_reference :positions, :grid, foreign_key: true
  end
end
