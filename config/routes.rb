Rails.application.routes.draw do
  resources :posts

  get 'webhook' => 'bot#webhook'
  post 'webhook' => 'bot#receive_message'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
