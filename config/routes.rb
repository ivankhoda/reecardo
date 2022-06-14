Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/vendor', to: 'vendors#create'
  get '/vendor/:id', to: 'vendors#show'
  patch '/vendor/:id', to: 'vendors#update'
  delete '/vendor/:id', to: 'vendors#destroy'
  get '/vendors', to: 'vendors#index'
  telegram_webhook TelegramWebhooksController
end
