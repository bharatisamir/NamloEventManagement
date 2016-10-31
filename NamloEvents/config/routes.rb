Rails.application.routes.draw do


  get 'market_place/index'

  #resources :quotations
  #resources :events
  resources :roles
  #resources :to_do_items
  #resources :to_do_lists
  resources :peer_reviews
  resources :reviews
  #resources :hosts

  devise_for :users

  resources :users do
    resources :profiles, only: [:new, :create, :edit, :update]
    resources :service_providers, only: [:new, :create, :edit, :update]
    resources :hosts, only: [:new, :create] do
      resources :events
    end
    resources :to_do_lists do
      resources :to_do_items do
        member do
          patch :complete
        end
      end
    end

  end


  resources :service_providers do
    resources :reviews
    resources :peer_reviews
  end

  resources :events do
    resources :quotations
  end
  #resources :profiles, only: [:new, :create, :edit]


 # get 'users/new'

  get 'dashboard/index'

  #get 'contact/index'

  get 'about/index'

  get 'home/index'


  #devise_for :users


  match '/contact', to:'contact#new', via: 'get'
  resources :contact, only: [:new, :create]


=begin
  devise_for :users, controllers: {
        sessions: 'users/sessions'
    }

  devise_for :users, controllers: {
      passwords: 'users/passwords'
  }

  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  devise_for :users, controllers: {
      unlocks: 'users/unlocks'
  }
=end

=begin
  devise_for :users, :controllers => {:sessions => 'users/sessions'}
  devise_for :users, :controllers => {:passwords => 'users/passwords'}
  devise_for :users, :controllers => {:registrations => 'users/registrations'}
  devise_for :users, :controllers => {:unlocks => 'users/unlocks'}
=end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

end
