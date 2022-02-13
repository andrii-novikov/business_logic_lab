Rails.application.routes.draw do
  resources :emeter_readings
  resource :report
  resources :bills

  namespace :admin do
    resources :emeter_readings, only: %i[create]
  end
end
