Rails.application.routes.draw do

resources :machines
resources :databases


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html*


  post '/queries/:id/preview', to: 'queries#launch_preview'
  get '/queries/:id/preview', to: 'queries#launch_preview'
  post '/queries/:id', to: 'queries#export_all'
  resources :queries

  root 'welcome#index', as:'home'



end
