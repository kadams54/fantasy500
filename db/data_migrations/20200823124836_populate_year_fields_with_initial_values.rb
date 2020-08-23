class PopulateYearFieldsWithInitialValues < ActiveRecord::DataMigration
  def up
    execute <<-SQL
      UPDATE drivers SET year = 2019;
      UPDATE grids SET year = 2019;
      UPDATE leagues SET year = 2019;
      UPDATE positions SET year = 2019;
      UPDATE teams SET year = 2019;
    SQL
  end
end
