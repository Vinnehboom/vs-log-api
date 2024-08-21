class ApplicationController < ActionController::API

  attr_reader :game, :user

  before_action :set_game
  before_action :verify_user
  include ApiErrors
  rescue_from UnauthorizedError, with: :unauthorized

  private

  def set_game
    @game = Game.find(params['game'])
  end

  def verify_user
    @user = FirebaseIdToken::Signature.verify(request.headers['HTTP_FIREBASE_ID_TOKEN'])

    raise UnauthorizedError unless @user
  end

  def user_id
    user['user_id']
  end

end
