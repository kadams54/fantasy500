class AddIndexToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_index :drivers, :number, unique: true
  end
end
