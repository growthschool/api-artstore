module ProductAPI

  class API < Grape::API

    prefix "products"

    format :json
    get :list do
      Product.all
    end
  end
end