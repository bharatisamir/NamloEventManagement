Rails.application.routes.draw do
 # get 'user/new'

  get 'dashboard/index'

  get 'contact/index'

  get 'about/index'

  get 'home/index'


  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

end
