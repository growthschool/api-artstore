module CardAPI

  class API < Grape::API
    
    prefix "cards"
    format :json
    
    params do
      requires :token, type: String, desc: "API Token for auth"
     # requires :number, type: String, desc: "CreditCard Number"
    end


    post do 
      @card = CreditCard.last
    end
  end
end