Rails.application.routes.draw do
  resources :emeter_readings
  resource :report
  resources :bills
end
