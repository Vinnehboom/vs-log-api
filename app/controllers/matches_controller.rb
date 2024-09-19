class MatchesController < ApplicationController

  def index
    @matches = matches
    @matches = apply_query_params(collection: @matches) if query_params.present?
    @matches = paginate @matches
    render json: @matches, expand: included_relations
  end

  private

  def matches
    Match.includes(:deck).where(deck: { user_id: })
  end

  def included_relations
    return [] if expand_params.blank?

    expand_params.map(&:to_sym)
  end

  def query_params
    params.permit(:archetype_id, :opponent_archetype_id)
  end

  def expand_params
    params.fetch(:expand, '').split(',').map(&:strip).select do |expansion|
      %w[match_games].include?(expansion)
    end
  end

end
