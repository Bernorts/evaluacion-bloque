Rails.application.routes.draw do

	#grid
	get '/malla',   to: 'grid#show', as: :show_grid

	#revisions
	get '/evaluaciones/nueva',   to: 'evaluations#new', as: :new_evaluation
	post '/evaluaciones/crear',   to: 'evaluations#create', as: :create_evaluation
end
