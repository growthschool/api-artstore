module ProductAPI

  class API < Grape::API

    prefix "products"

    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    get :list do
      @products = Product.all
    end

    resource :add_to_cart do 
      params do
        requires :token, type: String, desc: "API Token for auth"
      end

      post do 
        @product = Product.find(params[:product_id])
      end
    end
  end
end