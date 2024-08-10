class UnauthorizedError < StandardError

  attr_reader :status, :message

  def initialize(message: I18n.t('errors.unauthorized'))
    @status = 401
    @message = message
    super
  end

end
