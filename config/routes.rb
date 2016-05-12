Rails.application.routes.draw do


  mount ProductAPI::API => '/'
  mount UserAPI::API => '/'

end
