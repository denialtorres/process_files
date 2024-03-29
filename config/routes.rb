Rails.application.routes.draw do
  root "visitors#index"

  resources :visitors do
    get :import, on: :collection
    post :import, on: :collection
    post :export, on: :collection
    post :delete_all, on: :collection
  end

  devise_for :users
end
