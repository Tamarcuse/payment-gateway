Rails.application.routes.draw do
  scope 'api' do
    post 'charge' => 'charges#create'
    get 'chargeStatuses' => 'charge_statuses#index'
  end

  resources :healthcheck
  get 'healthcheck' => 'healthcheck#index'
end
