class AddYear < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :year, :integer
    add_column :grids, :year, :integer
    add_column :leagues, :year, :integer
    add_column :positions, :year, :integer
    add_column :teams, :year, :integer
  end
end
