class DecksController < ApplicationController

  def index
    @decks = decks
    render json: @decks
  end

  def show
    @deck = decks.find(params[:id])
    render json: @deck
  end

  def create
    @deck = decks.new(deck_params)
    if @deck.save
      render @deck, status: :created
    else
      render @deck.errors, status: :unprocessable_entity
    end
  end

  def update
    @deck = decks.find(params[:id])
    if @deck.update(deck_params)
      render @deck
    else
      render @deck.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @deck = decks.find(params[:id])
    if @deck.destroy
      head :no_content
    else
      render @deck.errors, status: :unprocessable_entity
    end
  end

  private

  def decks
    Deck.includes(:archetype).where(game:, user_id:)
  end

  def deck_params
    params.require(:deck).permit(:name, :archetype_id, :active)
  end

end
