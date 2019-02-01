Rails.application.routes.draw do
  root to: 'urls#index'
  resources :urls, only: [:create, :show]

  # shortened url
  get '/:code', to: 'urls#get', as: 'get_url'
end
