Rails.application.routes.draw do
  resources :cages
  resources :dinosaurs

  get '/cages/:id/dinosaurs', to: 'cages#show_dinosaurs'
  get '/cages/status/active', to: 'cages#show_active'
  get '/cages/status/inactive', to: 'cages#show_inactive'
  get '/dinosaurs/species/:species', to: 'dinosaurs#by_species'
end
