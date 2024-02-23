Rails.application.routes.draw do
  root "visitors#index"

  resources :visitors do
    get :import, on: :collection
    post :import, on: :collection
  end

  devise_for :users
end
