MtntApi::Application.routes.draw do
  scope(module: :v1, defaults: { format: :json }) do
    resources :entries do
      resources :votes, only: [:create]
    end

    resources :users

    resources :sessions, only: [:create]
  end
end
