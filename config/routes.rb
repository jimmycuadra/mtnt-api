MtntApi::Application.routes.draw do
  scope(module: :v1, defaults: { format: :json }) do
    resources :entries
    resources :users
  end
end
