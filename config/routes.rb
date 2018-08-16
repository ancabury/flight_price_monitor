Rails.application.routes.draw do
  root to: 'flights#index'
  resources :flights do
    put :stop_watching, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
