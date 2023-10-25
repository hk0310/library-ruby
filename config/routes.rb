Rails.application.routes.draw do
  root to: "books#index"

  resources :books, only: %i[index show]
  # root "articles#index"
end
