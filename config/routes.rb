Rails.application.routes.draw do
  get '/malla',   to: 'grid#show', as: :show_grid
  get '/usuario/:id', to: 'users#show', as: :show_user
  get '/usuarios/nuevo', to: 'users#new', as: :new_user
  get '/usuario/:id/editar', to: 'users#edit', as: :edit_user
  patch '/usuario/:id/editUserData', to: 'users#editUserData', as: :edit_user_data
  post '/usuarios', to: 'users#create', as: :users
  patch '/usuario/:id', to: 'users#update', as: :update_user
  delete '/usuario/:id', to: 'users#delete', as: :delete_user
  get '/usuarios/:id', to: 'users#index', as: :all_semester_users
end
