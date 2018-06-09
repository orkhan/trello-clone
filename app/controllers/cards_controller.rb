class CardsController < ApplicationController

  before_action :set_card, except: :create

  def show
  end

  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.json { render :show, status: :created, location: @card }
      else
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.json { render :show, status: :ok, location: @card }
      else
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @card.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def move
    @card.update(card_params)
  end

  private

    def set_card
      @card = Card.find(params[:id])
    end
    
    def card_params
      params.require(:card).permit(:title, :list_id)
    end
end
