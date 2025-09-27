class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  allow_browser versions: :modern unless Rails.env.test?
  # protect
  protect_from_forgery with: :null_session

  private

  def render_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

end
