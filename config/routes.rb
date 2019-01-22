Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope "v1" do
    resources :media_files, only: [:create, :show, :update, :destroy]
  end

  resources :healthcheck, only: [:index]
end
