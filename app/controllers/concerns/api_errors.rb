module ApiErrors

  def unauthorized(exception)
    errors = [exception]
    json_response = format_errors(errors)
    render json: json_response, status: :unauthorized
  end

  private

  def format_errors(errors)
    {
      errors:
        errors.map { |error| { status: error.status, message: error.message } }
    }
  end

end
