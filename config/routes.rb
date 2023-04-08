Rails.application.routes.draw do
  resources :ligues
 
  root "home#index"
 
  resources :posts

  resources :pilotes do
    member do
      post :edit
      get :nouveau_pilote
    end
  end



end
