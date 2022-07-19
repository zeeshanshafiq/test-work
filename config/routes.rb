Rails.application.routes.draw do
  resources :disbursements, only: [] do
    collection do
      get '/:date', to: 'disbursements#index', as: :filter
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
