module CardAPI

  class API < Grape::API
    
    prefix "cards"
    format :json
    
    params do
      requires :token, type: String, desc: "API Token for auth"
    end
\

    post do 
      @card = CreditCard.last
    end
  end
end