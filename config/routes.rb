Rails.application.routes.draw do
  

  resources :incomes
  resources :general_spends
  resources :cost_centers
  resources :type_spends
  devise_for :users
  
  root 'home#construccion'
  get 'inicio', to:'home#inicio'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
