Rails.application.routes.draw do
  scope 'api' do
    post 'charge' => 'charges#create'
  end

  resources :healthcheck
  get 'healthcheck' => 'healthcheck#index'
end
