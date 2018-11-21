class DriversController < ApplicationController
  def index
    @drivers = Driver.all
  end

  def show
    @driver = Driver.find(params[:id])
  end

  def new
  end

  def create
    @driver = Driver.new(driver_params)

    @driver.save
    redirect_to @driver
  end

  private
    def driver_params
      params.require(:driver).permit(:name, :number, :team, :make_model)
    end
end
