class AddCommishIdToLeagues < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :commish_id, :bigint
    add_index  :leagues, :commish_id
    add_foreign_key :leagues, :users, column: :commish_id
  end
end
