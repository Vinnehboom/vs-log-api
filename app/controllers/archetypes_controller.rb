class ArchetypesController < ApplicationController

  def index
    @archetypes = archetypes
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

end
