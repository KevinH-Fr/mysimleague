Rails.application.routes.draw do
  resources :resultats
  resources :events
  resources :circuits
  resources :divisions
  resources :saisons
  resources :equipes
  resources :friends
 
  root "home#index"
 
  resources :posts

  resources :pilotes do
    member do
      post :edit
     # get :nouveau_pilote
    end
  end

  resources :ligues do
    member do
      post :edit
    end
  end



end
