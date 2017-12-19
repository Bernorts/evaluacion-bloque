Rails.application.routes.draw do

	#grid
	get '/malla',   to: 'grid#show', as: :show_grid

	#revisions
	get '/revisiones/nuevo',   to: 'revisions#new', as: :new_revision
	post '/revisiones/crear',   to: 'revisions#create', as: :create_revision
end
