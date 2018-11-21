class PositionsController < ApplicationController
  def create
    @grid = Grid.find(params[:grid_id])
    @position = @grid.positions.create(position_params)

    redirect_to grid_path(@grid)
  end

  def destroy
    @grid = Grid.find(params[:grid_id])
    @position = @grid.positions.find(params[:id])
    @position.destroy

    redirect_to grid_path(@grid)
  end

  private
    def position_params
      params.require(:position).permit(:place, :driver_id)
    end
end
