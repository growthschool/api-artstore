module UserAPI
  module AuthHelper
    def current_user
      @current_user ||= authenticate
    end

    def authenticate
      user = User.where(:authentication_token => params[:token]).first
    end

    def authenticate!
      error!({ "error" => {"code" => "401", "message" => "Your session has expired. Please log in again."}}, 401) unless current_user
    end
  end
end
