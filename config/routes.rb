Rails.application.routes.draw do
  root to: "books#index"

  resources :books, only: %i[index show]
  resources :authors, only: %i[index show]
  resources :genres, only: %i[index show]

  get "/about-us" => "pages#about-us"
  get 'search_results', to: 'search#results', as: 'search_results'
end
