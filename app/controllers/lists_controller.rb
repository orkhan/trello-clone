class ListsController < ApplicationController

  before_action :set_list, except: :create

  def show
  end
  
  def create
    @list = List.new(list_params)

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

    def set_list
      @list = List.find(params[:id])
    end
    
    def list_params
      params.require(:list).permit(:board_id, :name)
    end
end
