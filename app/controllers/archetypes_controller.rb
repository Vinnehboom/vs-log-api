class ArchetypesController < ApplicationController

  def index
    @archetypes = archetypes
    @archetypes = apply_query_params(archetypes: @archetypes) if query_params.present?

    render json: @archetypes
  end

  def show
    @archetype = archetypes.find(params[:id])
    render json: @archetype
  end

  private

  def archetypes
    Archetype.where(game:)
  end

  def query_params
    params.permit(:identifier, :name, :generation)
  end

  def apply_query_params(archetypes:)
    query_params.to_h.each do |attribute, value|
      archetypes = archetypes.and(archetypes.contains(attribute, value))
    end
    archetypes
  end

end
