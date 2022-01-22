
class BaseApi < Grape::API
  helpers do
    def authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    end
    def current_user
      if request.headers['Authorization'].present?
        token = request.headers['Authorization'].split(' ').last
        if token.present?
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

          @current_user_id = jwt_payload['id']
          @current_user = User.find(@current_user_id)
        else
          nil
        end
      end
    end
  end
end
