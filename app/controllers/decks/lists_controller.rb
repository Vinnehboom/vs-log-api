module Decks

  class ListsController < DecksController

    before_action :set_deck

    def index
      @lists = lists

      @lists = @lists.includes(expand_params.map(&:to_sym)) if included_relations.present?
      render json: @lists, expand: included_relations
    end

    def show
      @list = lists.includes(:cards).find(params[:id])
      render json: @list, expand: [:cards]
    end

    def create
      @list = build_list
      if @list.save
        render json: @list, status: :created
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end

    def update
      @list = lists.find(params[:id])
      if @list.update(list_params)
        render json: @list
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @list = lists.find(params[:id])
      if @list.destroy
        head :no_content
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end

    private

    def set_deck
      @deck = decks.find(params[:deck_id])
    end

    def included_relations
      return {} if expand_params.blank?

      expand_params.map(&:to_sym)
    end

    def lists
      @deck.lists.where(query_params)
    end

    def build_list
      cards = parse_cards
      lists.new(**list_params, cards_attributes: cards)
    end

    def query_params
      params.permit(:active)
    end

    def card_params
      params.require(:list).permit(cards: [])
    end

    def list_params
      params.require(:list).permit(:name, :active)
    end

    def expand_params
      params.fetch(:expand, '').split(',').map(&:strip).select do |expansion|
        %w[cards].include?(expansion)
      end
    end

    def parse_cards
      Lists::ParserFactory.call(game: @game).parse(cards:)
    end

    def cards
      card_params[:cards]
    end

  end

end
