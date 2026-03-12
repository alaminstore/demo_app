Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  def draw(name)
    instance_eval(File.read(Rails.root.join("config/routes/#{name}.rb")))
  end

  draw :web
  draw :mobile

  # All API routes should live under /api
  scope :api do
    # Example:
    # namespace :v1 do
    #   resources :users
    # end
    resources :users, only: [:show]

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    # get "up" => "rails/health#show", as: :rails_health_check
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  #
  #
end
