Rails.application.routes.draw do



  resources :survey_question_responses


  resources :surveys do
    resources :survey_questions
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  #resources :offers
  resources :pictures
  #resources :galleries
  #resources :portfolios
  get '/event_details', to: "invitations#event_detail"



  resources :invitations
  resources :bookings
  #get 'event_order_details/update_event', as: 'update_event'
  #resources :event_order_details

  #map.connect ':controller/:action.:format'

  #get ':controller(/:action(/:id(.:format)))'

  resources :services


  resources :menus do
    resources :menu_items
  end

  resources :event_orders do
    resources :event_order_details
  end

  #resources :reservations
  #resources :guest_lists
  #resources :incomes
  #resources :expenses
  get 'market_place/index'

  #resources :quotations
  #resources :events
  resources :roles
  #resources :to_do_items
  #resources :to_do_lists
  #resources :peer_reviews
  #resources :reviews
  #resources :hosts

  devise_for :users

  resources :users do
    resources :profiles, only: [:new, :create, :edit, :update]
    resources :service_providers
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
    resources :portfolios
    resources :offers
    #resources :bookings
  end



  resources :portfolios do
    resources :galleries
  end




  resources :events do
    resources :quotations
    resources :expenses
    resources :incomes
    resources :guest_lists
    resources :reservations
  end
  #resources :profiles, only: [:new, :create, :edit]


 # get 'users/new'

  get 'dashboard/index'

  #get 'contact/index'

  get 'about/index'

  get 'home/index'


  #devise_for :users

 match '/event_order_details/update_event', to: 'event_order_details#update_event', via: 'get'
  match '/contact', to:'contact#new', via: 'get'
  resources :contact, only: [:new, :create]

  match '/email', to:'email#new', via: 'get'
  resources :email, only: [:new, :create]

  match '/mail_invitation', to: "events#mail_invitation", via: 'get'

  match '/event_report', to: "events#event_report", via: 'get'

  match '/expense_report', to: "events#expense_report", via: 'get'

  match '/revenue_report', to: "events#revenue_report", via: 'get'

  match '/reserved_guest_report', to: "events#reserved_guest_report", via: 'get'

  match '/reserved_menu_report', to: "menus#reserved_menu_report", via: 'get'

  match '/booking_report', to: "bookings#booking_report", via: 'get'

  match '/provider_booking_report', to: "bookings#provider_booking_report", via: 'get'

  match '/event_order_report', to: "event_orders#event_order_report", via: 'get'
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

  match '*path', :to => 'application#routing_error', via: 'get'

end
