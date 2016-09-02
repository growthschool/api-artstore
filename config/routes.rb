Rails.application.routes.draw do

 
  mount ProductAPI::API => '/'
  mount UserAPI::API => '/'
  mount CardAPI::API => '/'
end
