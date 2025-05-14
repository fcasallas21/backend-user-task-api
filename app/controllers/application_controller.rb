class ApplicationController < ActionController::API
  def authorize_request
    return true if Rails.env.test? || ENV['SKIP_AUTH'] == 'true'
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = AppUser.find(@decoded[:app_user_id])
      render json: { message: 'Token válido' }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue StandardError
      render json: { errors: 'ERROR' }, status: :unauthorized
    end
  end
end
