Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :contect_forms, only: :create
  root to: "contact_forms#new"
end
