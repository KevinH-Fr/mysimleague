Rails.application.routes.draw do

  resources :menu do
    post 'display_admins_ligue', on: :collection
    post 'display_rattachements_ligue', on: :collection

    post 'display_reglements_ligue', on: :collection
    post 'display_pilotes_division', on: :collection
    post 'display_dupliquer_events_division', on: :collection

    post 'display_resultats', on: :collection


    post 'display_presences', on: :collection
    post 'display_dotds', on: :collection
    post 'display_dois', on: :collection
    post 'display_paris', on: :collection

    post 'display_licences', on: :collection
    post 'display_synthese_licences', on: :collection
    post 'display_classement_equipes', on: :collection
    post 'display_classement_pilotes', on: :collection

  end

  resources :home do
    post 'display_parieurs', on: :collection
    post 'display_demande_rattachement', on: :collection
    post 'display_creer_ligue', on: :collection

    post 'display_parieurs_annee', on: :collection
    post 'display_pilotes', on: :collection

  end

  get 'synthese_licences/index'

  get 'parieurs/index'
  get 'cotes/index'
  get 'classement_equipes/index'


  resources :rattachements do
    member do
      post :edit
    end
  end

  resources :presences do
    member do
      post :edit
    end
  end

  resources :resultats do

    member do
      post :edit
    end
  end


  resources :paris do
    member do
      post :edit
    end
  end

  resources :circuits do
    member do
      post :edit
    end
  end

  resources :ligues do
    member do
      post :edit
    end
  end

  resources :equipes do 
    member do
      post :edit
    end
  end

  resources :divisions do
    member do
      post :edit
    end
  end

  resources :saisons do
    member do
      post :edit
    end
  end

  resources :events do
    member do
      post :edit
    end
  end
  post 'duplication_event', to: 'events#duplication', as: :duplication_event

  resources :association_users do
    member do
      post :edit
    end
  end

  resources :association_admins do
    member do
      post :edit
    end
  end

  resources :dotds do
    member do
      post :edit
    end
  end

  resources :reglements do
    member do
      post :edit
    end
  end

  resources :licences do
    member do
      post :edit
    end
  end

  get 'update_licences/:event', to: 'licences#update_licences', as: 'update_licences'
  get 'supprimer_licences/:event', to: 'licences#supprimer_licences', as: 'supprimer_licences'

  resources :dois do
    member do
      post :edit
    end
  end

  get 'steps_compte/step1'
  get 'steps_compte/step2'
  get 'steps_compte/step3'

  get 'classement_pilotes/index'

  get 'home/index'

  get 'animation', to: 'resultats#animation', as: 'animation'

  get 'generate_image_resultats', to: 'resultats#generate_image', as: 'generate_image_resultats'
  get 'generate_image_resultats_bis', to: 'resultats#generate_image_bis', as: 'generate_image_resultats_bis'

  get 'generate_image_class_pilotes', to: 'classement_pilotes#generate_image', as: 'generate_image_class_pilotes'

  get 'generate_image_class_equipes', to: 'classement_equipes#generate_image', as: 'generate_image_class_equipes'
  
  get 'generate_image_dois', to: 'dois#generate_image', as: 'generate_image_dois'

  get 'generate_image_licences', to: 'synthese_licences#generate_image', as: 'generate_image_licences'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  #devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'users' => 'users#index', as: 'users'

  get 'users/show'
  get 'users/:id' => 'users#show', as: 'user'

  get 'users/edit'
  get 'users/:id' => 'users#edit', as: 'user_edit'

  resources :friends

  root to: 'home#index'

  mount ActiveAnalytics::Engine, at: "analytics"

end
