class BoardsController < ApplicationController

  before_action :set_board, only: :show

  def show
  end

  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.json { render :show, status: :created, location: @board }
      else
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_board
      @board = Board.find_by_uid(params[:id])
    end
    

    def board_params
      params.require(:board).permit(:name)
    end
end
