Rails.application.routes.draw do

  devise_for :users
  mount ProductAPI::API => '/'

end
