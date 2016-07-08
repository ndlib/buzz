class ApplicationController < ActionController::API
  def render_validation_errors(object:)
    render json: { status: 422, errors: object.errors }, status: :unprocessable_entity
  end
end
