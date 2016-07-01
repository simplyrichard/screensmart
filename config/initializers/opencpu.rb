require 'opencpu'
OpenCPU.configure do |config|
  config.endpoint_url = ENV['OPENCPU_ENDPOINT_URL']
  config.username     = ENV['OPENCPU_USERNAME']
  config.password     = ENV['OPENCPU_PASSWORD']
  config.timeout      = 5
end
