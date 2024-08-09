class DecksController < ApplicationController

  def index
    @decks = Deck.where(game:)
    render json: @decks
  end

  def show
    @deck = Deck.where(game:).find(params[:id])
    render json: @deck
  end

end
