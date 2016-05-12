module UserAPI

  class API < Grape::API

    prefix "users"
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

 
    post :sign_in do
      
      user = User.where(:email => params[:user][:email].downcase).first

      if user.nil?
        error!({ "error" => {"code" => "482", "message" => "User Email not found"}}, 400)
      end

      if !user.authenticate(params[:user][:password])
        error!({ "error" => {"code" => "482", "message" => "Password is incorrect"}}, 400)
      end


      Rails.logger.info params

      {
        token: user.authentication_token,
        email: user.email
      }

    end

  end
end