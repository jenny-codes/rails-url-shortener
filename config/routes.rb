Rails.application.routes.draw do
  root to: 'urls#index'
  
  get '/:code', to: 'urls#get', as: 'get_url', constraints: { code: /[A-Z0-9]{4}/ }
  resources :urls, except: [:index, :edit, :update]
end
