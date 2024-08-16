module Decks

  class ListsController < DecksController

    before_action :set_deck

    def index
      @lists = lists
      render json: @lists
    end

    def show
      @list = lists.find(params[:id])
      render json: @list
    end

    private

    def set_deck
      @deck = decks.find(params[:deck_id])
    end

    def lists
      @deck.lists
    end

  end

end
