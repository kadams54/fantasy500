class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find(params[:id])
  end

  def new
    @driver = Driver.new
  end

  def edit
    @driver = Driver.find(params[:id])
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to @driver
    else
      render "new"
    end
  end

  def update
    @driver = Driver.find(params[:id])

    if @driver.update(driver_params)
      redirect_to @driver
    else
      render "edit"
    end
  end

  def destroy
    @driver = Driver.find(params[:id])
    @driver.destroy

    redirect_to drivers_path
  end

  private

  def driver_params
    params.require(:driver).permit(:name, :driver_image, :number, :car_image, :team, :make_model, :qualifying_speed)
  end
end
