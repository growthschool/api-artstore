module CardAPI

  class API < Grape::API
    
    prefix "cards"
    format :json
    
    helpers UserAPI::AuthHelper

    params do
      requires :token, type: String, desc: "API Token for auth"
      requires :number, type: String, desc: "CreditCard Number"
      requires :cvc , type: String, desc: "CreditCard CVC"
      requires :exp_month , type: String, desc: "CreditCard Exp Month"
      requires :exp_year , type: String, desc: "CreditCard Exp Year"
    end


    post do 


      authenticate!

      
      current_user.create_card!(params[:number], params[:cvc], params[:exp_month], params[:year])

      @card = current_user.credit_cards.last
    end
  end
end