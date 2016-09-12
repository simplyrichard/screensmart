class ApplicationMailer < ActionMailer::Base
  domain = ENV.fetch('MAILGUN_DOMAIN', 'roqua.nl')
  default from: "noreply@#{domain}"
  layout 'email'
end
