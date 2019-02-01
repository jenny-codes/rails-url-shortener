Rails.application.routes.draw do
  root to: 'urls#index'
  resources :urls, except: [:index, :edit, :update]

  # shortened url
  get '/:code', to: 'urls#get', as: 'get_url'
end
