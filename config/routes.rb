Rails.application.routes.draw do
  mount Rack::HaproxyStatus::Endpoint.new(path: Rails.root.join('config/balancer_state')) => '/load_balancer_status'
  root to: 'app#index'

  scope defaults: { format: 'json' }, constraints: { format: 'json' } do
    resources :responses, only: [:create, :show, :update]
    resources :adhoc_responses, only: [:create]
    # get 'responses', controller: 'responses', action: 'show', as: 'response'
    resources :answers, only: [:create]
    resources :domains, only: [:index]
    resources :invitations, only: [:create]
  end

  get '/fillOut' => 'app#index', as: 'fill_out'
  get '/show' => 'app#index', as: 'show_response'
  get '*path' => 'app#index' # Handle routing using react-redux-router
end
