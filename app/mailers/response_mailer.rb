class ResponseMailer < ApplicationMailer
  def response_email(requester_email:, response_uuid:)
    @link = "future_link_to_finished_response/#{response_uuid}"

    mail to: requester_email,
         subject: "Resultaten screening #{response_uuid}"
  end
end
