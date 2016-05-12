module ProductAPI

  class API < Grape::API

    prefix "products"

    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    get :list do
      @products = Product.all

    end
  end
end