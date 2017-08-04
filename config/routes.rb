Rails.application.routes.draw do

  namespace :admin do
    resources :dashboard, only: :index
  end

  resources :users
  resources :tags

  resources :products do
     resources :reviews
   end
   resources :products do
      resources :favorites
    end

   resources :reviews do
      resources :likes
    end

   resource :session
  # get 'products/:id'x
  # get 'products/show'
  # get 'products/new'

  # get 'products/create'

  get 'question/new'

  get 'question/create'
  get('/', to: 'home#index')\

  get('questions/new', to: 'questions#new', as: :new_question)
  post('questions/', to: 'questions#create', as: :questions)

  get('/home', to: 'home#index')
  get('/about', to: 'about#index')
  get('/contact_us', to: 'contact_us#index')
  post '/contact_us', to: 'contact_us#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
