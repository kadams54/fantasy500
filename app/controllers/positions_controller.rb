class PositionsController < ApplicationController
  def create
    @driver = Driver.find(params[:driver_id])
    @position = @driver.positions.create(position_params)

    redirect_to driver_path(@driver)
  end

  private
    def position_params
      params.require(:position).permit(:place, :lap)
    end
end
