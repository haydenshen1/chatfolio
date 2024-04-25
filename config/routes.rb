Rails.application.routes.draw do
  get 'portfolio/chatfolio'
  get 'portfolio/ispend'
  get 'chatfolio/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'chatfolio#index'

  post 'generate_response', to: 'chatfolio#generate_response'
end
