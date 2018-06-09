class ListsController < ApplicationController

  before_action :set_board
  before_action :set_list, only: :destroy

  def create
    @list = @board.lists.new(list_params)

    respond_to do |format|
      if @list.save
        format.json { render :show, status: :created, location: @list }
      else
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def set_board
      @board = Board.find_by_uid(params[:board_id])
    end

    def set_list
      @list = @board.lists.find(params[:id])
    end
    
    def list_params
      params.require(:list).permit(:name)
    end
end
