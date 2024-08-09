class ApplicationController < ActionController::API

  attr_reader :game
  before_action :set_game

  private

  def set_game
    @game = Game.find(params['game'])
  end
end
