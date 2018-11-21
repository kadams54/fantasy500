class AddImagesAndSpeedToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :driver_image, :string
    add_column :drivers, :car_image, :string
    add_column :drivers, :qualifying_speed, :float
  end
end
