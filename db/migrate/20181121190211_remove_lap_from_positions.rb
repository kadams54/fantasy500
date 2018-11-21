class RemoveLapFromPositions < ActiveRecord::Migration[5.2]
  def change
    remove_column :positions, :lap, :integer
  end
end
