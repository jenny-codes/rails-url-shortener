Rails.application.routes.draw do
  root to: 'urls#index'
  
  get '/:code', to: 'urls#show', as: 'get_url', constraints: { code: /[A-Z0-9]{4}/ }
  resources :urls, except: [:index, :edit, :show]
end
