Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "parcel#index"

  get "/", to:"parcel#index"
  post "/",  to:"parcel#new"
end
