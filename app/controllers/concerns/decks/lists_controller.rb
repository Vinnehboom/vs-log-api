module Decks

  class ListsController < DecksController

    before_action :set_deck

    def index
      @lists = lists
      render json: @lists, include: { list_cards: { only: %i[count name set_id set_number] } }
    end

    def show
      @list = lists.find(params[:id])
      render json: @list, include: { list_cards: { only: %i[count name set_id set_number] } }
    end

    def create
      @list = lists.new(create_params)
      if @list.save
        render json: @list, status: :created
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end

    def update
      @list = lists.find(params[:id])
      if @list.update(update_params)
        render json: @list
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end

    private

    def set_deck
      @deck = decks.find(params[:deck_id])
    end

    def lists
      @deck.lists.where(query_params)
    end

    def query_params
      params.permit(:active)
    end

    def create_params
      params.require(:list).permit(:name, :active, cards: %i[name count])
    end

    def update_params
      params.require(:list).permit(:name, :active)
    end

  end

end
