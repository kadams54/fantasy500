class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :leagues, :password_digest, :membership_digest
  end
end
