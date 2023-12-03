class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  private

  def render_unprocessable_entity
    render json: { errors: ['Unprocessable entity'] }, status: :unprocessable_entity
  end
end
