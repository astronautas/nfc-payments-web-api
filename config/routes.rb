Rails.application.routes.draw do
  post '/login', to: 'users#login'
  post '/register', to: 'users#create'
end
