ip = '10.240.90.11'
server ip, user: 'deploy', roles: %w{ app web }, rails_env: :production
set :deploy_to, "/var/www/#{ip}"
