Rails.application.routes.draw do
  post '/login', to: 'users#login'
  post '/register', to: 'users#create'
  get '/auth_test', to: 'users#pass'
end
