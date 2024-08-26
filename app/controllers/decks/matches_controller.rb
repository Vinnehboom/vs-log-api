module Decks

  class MatchesController < DecksController

    before_action :set_deck

    def index
      @matches = matches

      render json: @matches, expand: included_relations
    end

    def show
      @match = matches.includes(:match_games).find(params[:id])
      render json: @match, expand: [:match_games]
    end

    def create
      @match = matches.new(create_params)
      if @match.save
        render json: @match, status: :created
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    end

    def update
      @match = matches.find(params[:id])
      if @match.update(update_params)
        render json: @match
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @match = matches.find(params[:id])
      if @match.destroy
        head :no_content
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    end

    private

    def set_deck
      @deck = decks.find(params[:deck_id])
    end

    def create_params
      params.require(:match).permit(:result,
                                    :remarks,
                                    :bo3,
                                    :coinflip_won,
                                    :archetype_id,
                                    :opponent_archetype_id,
                                    match_games_attributes:)
    end

    def update_params
      params.require(:match).permit(:remarks)
    end

    def match_games_attributes
      %i[result started]
    end

    def matches
      @deck.matches.includes(:archetype, :opponent_archetype, :match_games)
    end

    def included_relations
      return [] if expand_params.blank?

      expand_params.map(&:to_sym)
    end

    def expand_params
      params.fetch(:expand, '').split(',').map(&:strip).select do |expansion|
        %w[match_games].include?(expansion)
      end
    end

  end

end
