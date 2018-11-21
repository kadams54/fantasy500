class GridsController < ApplicationController
  def index
    @grids = Grid.all
  end

  def show
    @grid = Grid.find(params[:id])
  end

  def new
    @grid = Grid.new
  end

  def edit
    @grid = Grid.find(params[:id])
  end

  def create
    @grid = Grid.new(grid_params)

    if @grid.save
      redirect_to @grid
    else
      render "new"
    end
  end

  def update
    @grid = Grid.find(params[:id])

    if @grid.update(grid_params)
      redirect_to @grid
    else
      render "edit"
    end
  end

  def destroy
    @grid = Grid.find(params[:id])
    @grid.destroy

    redirect_to grids_path
  end

  private

  def grid_params
    params.require(:grid).permit(:lap)
  end
end
