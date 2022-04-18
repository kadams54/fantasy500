class IndexOnDriverYearAndName < ActiveRecord::Migration[7.0]
  def change
    remove_index :drivers, [:number, :year]
    add_index :drivers, [:name, :year], unique: true
  end
end
