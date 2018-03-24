Rails.application.routes.draw do
  default_url_options :host => Rails.application.config.action_mailer.default_url_options
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations:      'overrides/registrations'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :health_check, only: [:index]
      resources :todos
      resources :invitations
    end
  end
end
