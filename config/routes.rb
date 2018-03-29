Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  #mount ActionCable.server => '/usuario/:id'

	root 'sessions#new'
	resources :evidences
	resources :semesters
	#grid
	get '/malla',   to: 'grid#show', as: :show_grid

	#interview
	get '/entrevista/:id', to: 'interviews#show', as: :show_interview
	post '/entrevista', to: 'interview#create', as: :create_evaluation_user
	put '/entrevista/:user_id/:ev_id/:level_id', to: 'interview#update', as: :update_evaluation_user


	#evaluations
	get '/evaluaciones/nueva',   to: 'evaluations#new', as: :new_evaluation
  get '/evaluaciones/:id/editar',   to: 'evaluations#edit', as: :edit_evaluation
	post '/evaluaciones/crear',   to: 'evaluations#create', as: :create_evaluation
  patch '/evaluaciones/crear',   to: 'evaluations#create', as: :patch_create_evaluation
  put '/evaluaciones/:id', to: 'evaluations#update', as: :update_evaluation
	put '/evaluaciones/evaluate/:id', to: 'evaluations#evaluate', as: :evaluate_evaluation
	put '/evaluaciones/feedback/:id', to: 'evaluations#feedback', as: :feedback_evaluation
  delete '/evaluaciones/:id', to: 'evaluations#destroy', as: :destroy_evaluation
	post "/evaluaciones/evaluator/:id", to: 'evaluations#add_professor', as: :add_evaluation_professor
	delete "/evaluaciones/evaluator/:id", to: 'evaluations#delete_professor', as: :delete_evaluation_professor

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
  get 'sessions/new'

  #semesters
  get '/semestres/:id/cambiar' , to: 'application#set_semester_url', as: :set_semester_url
end
