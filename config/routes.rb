Rails.application.routes.draw do

  root "home#index"

  resources :friends
  resources :classementpilotes
  resources :posts

  resources :circuits do
    member do
      post :edit
    end
  end

  resources :pilotes do
    member do
      post :edit
    end
  end

  resources :ligues do
    member do
      post :edit
    end
  end

  resources :saisons do
    member do
      post :edit
    end
  end

  resources :divisions do
    member do
      post :edit
    end
  end

  resources :equipes do
    member do
      post :edit
    end
  end

  resources :events do
    member do
      post :edit
    end
  end

  resources :resultats do
    member do
      post :edit
    end
  end

end
