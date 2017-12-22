Rails.application.routes.draw do

	resources :evidences
	#grid
	get '/malla',   to: 'grid#show', as: :show_grid

	#evaluations
	get '/evaluaciones/nueva',   to: 'evaluations#new', as: :new_evaluation
  get '/evaluaciones/:id/editar',   to: 'evaluations#edit', as: :edit_evaluation
	post '/evaluaciones/crear',   to: 'evaluations#create', as: :create_evaluation
  get 'sessions/new'
	#users
  get '/usuario/:id', to: 'users#show', as: :show_user
  get '/usuarios/nuevo', to: 'users#new', as: :new_user
  get '/usuario/:id/editar', to: 'users#edit', as: :edit_user
  get '/usuario/:id/editUserData', to: 'users#editUser', as: :edit_user_data
  put '/usuario/:id', to: 'users#update_user', as: :update_user_data
  post '/usuarios', to: 'users#create', as: :users
  patch '/usuario/:id', to: 'users#update', as: :update_user
  delete '/usuario/:id', to: 'users#destroy', as: :destroy_user
  get '/usuarios/', to: 'users#index', as: :all_semester_users
	#sessions
  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create', as: :session_create
  delete '/logout',  to: 'sessions#destroy', as: :logout
end
