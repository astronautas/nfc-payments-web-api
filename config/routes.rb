Rails.application.routes.draw do
  post '/login', to: 'users#login'
  post '/register', to: 'users#create'

  post '/pay-order', to: 'orders#pay'
  post '/create-order', to: 'orders#create'
end
