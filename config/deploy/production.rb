server '10.240.90.11', user: 'deploy', roles: %w{ app web }, rails_env: :production
set :deploy_to, '/var/www/screensmart-playground.roqua.nl'
