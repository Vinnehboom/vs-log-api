module Decks

  class MatchesController < DecksController

    before_action :set_deck

    def index
      @matches = matches
      @matches = @matches.includes(included_relations) if included_relations.present?

      render json: @matches, expand: included_relations
    end

    def show
      @match = matches.includes(:match_games).find(params[:id])
      render json: @match, expand: [:match_games]
    end

    private

    def set_deck
      @deck = decks.find(params[:deck_id])
    end

    def matches
      @deck.matches.includes(:archetype, :opponent_archetype)
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
