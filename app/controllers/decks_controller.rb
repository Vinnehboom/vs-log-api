class DecksController < ApplicationController

  def index
    @decks = decks
    render json: @decks
  end

  def show
    @deck = decks.find(params[:id])
    render json: @deck
  end

  private

  def decks
    Deck.where(game:, user_id: @user['user_id'])
  end

end
