Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :show]
      resources :rents, only: [:index, :create]

      devise_for :users, singular: :user,
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'users'
        },
        controllers: {
          sessions: 'api/v1/sessions',
          registrations: 'api/v1/registrations'
        } 
    end
  end
end
