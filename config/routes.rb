Rails.application.routes.draw do
  mount Rack::HaproxyStatus::Endpoint.new(path: Rails.root.join('config/balancer_state')) => '/load_balancer_status'
  get '/', to: 'app#index'

  resources :responses, defaults: { format: :json }
end
