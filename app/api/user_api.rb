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

      {
        token: user.authentication_token,
        email: user.email
      }

    end

    post :sign_up do 
 
       if params[:user][:email].blank?
         error!({ "error" => {"code" => "482", "message" => "email can't be blank"}}, 400)
       end
 
       user = User.where(:email => params[:user][:email].downcase)
 
       if user.present?
         error!({ "error" => {"code" => "482", "message" => "user already registered"}}, 400)
       end
 
       if !(params[:user][:password].present? && params[:user][:password_confirmation].present? )
         error!({ "error" => {"code" => "603", "message" => "Password can't be blank."}}, 400)
       end
 
 
       if params[:user][:password] != params[:user][:password_confirmation]
         error!({ "error" => {"code" => "603", "message" => "Password don't match"}}, 400)
       end
 
       new_user = User.new(:email => params[:user][:email], :password => params[:user][:password],
         :password_confirmation => params[:user][:password_confirmation] )
       new_user.save
 
 
       {
         token: new_user.authentication_token,
         email: new_user.email
       }
 
    end

  end
end