Rails.application.routes.draw do  
  get '/malla',   to: 'grid#show', as: :show_grid
end
