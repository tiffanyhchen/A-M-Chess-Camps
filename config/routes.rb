Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search
  root 'home#index'

  # Routes for main resources
  resources :camps
  resources :instructors
  resources :locations
  resources :curriculums
  resources :families
  resources :students

  # Authentication routes
  resources :sessions
  resources :users
  get 'users/new', to: 'users#new', as: :signup
  get 'user/edit', to: 'users#edit', as: :edit_current_user

  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Routes for managing camp instructors
  get 'camps/:id/instructors', to: 'camps#instructors', as: :camp_instructors
  post 'camps/:id/instructors', to: 'camp_instructors#create', as: :create_instructor
  delete 'camps/:id/instructors/:instructor_id', to: 'camp_instructors#destroy', as: :remove_instructor

  get 'camps/:id/students', to: 'camps#students', as: :registrations
  post 'camps/:id/students', to: 'registrations#create', as: :create_student
  delete 'camps/:id/students/:student_id', to: 'registrations#destroy', as: :remove_student

  # get 'registrations/new', to: 'registrations#new', as: :new_registration
  # post 'registrations', to: 'registrations#create', as: :registrations
  # delete 'registrations', to: 'registrations#destroy', as: :registration

  get "view_cart" => "carts#view_cart", as: :view_cart
  post "add_to_cart" => "carts#add_to_cart", as: :add_to_cart
  get "checkout_page" => "carts#checkout_page", as: :checkout_page
  post "checkout_cart" => "carts#checkout_cart", as: :checkout_cart
  get "confirmation" => "carts#confirmation", as: :confirmation
  delete "delete_from_cart" => "carts#delete_from_cart", as: :delete_from_cart
  #post "registrations/add_to_cart/:id" => "items#add_to_cart", as: :add_to_cart
  # post "items/remove_one_from_cart/:id" => "items#remove_one_from_cart", as: :remove_one_from_cart
  # post "items/delete_from_cart/:id" => "items#delete_from_cart", as: :delete_from_cart
end
