class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_unprocessable_entity
    render json: { errors: ['Unprocessable entity'] }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { errors: ['Record not found'] }, status: :not_found
  end
end
