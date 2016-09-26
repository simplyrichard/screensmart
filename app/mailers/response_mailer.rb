class ResponseMailer < ApplicationMailer
  def response_email(requester_email:, show_secret:)
    @link = show_response_url(showSecret: show_secret)

    mail to: requester_email,
         subject: 'Resultaten screening'
  end
end
