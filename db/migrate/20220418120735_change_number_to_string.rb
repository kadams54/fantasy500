class ChangeNumberToString < ActiveRecord::Migration[7.0]
  def up
    change_column :drivers, :number, :string
  end
  def down
    change_column :drivers, :number, 'integer USING CAST(number AS integer)'
  end
end
