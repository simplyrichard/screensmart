class ResponseMailer < ApplicationMailer
  def response_email(requester_email:, show_secret:)
    @link = "#{url_options[:host]}/show?showSecret=#{show_secret}"

    mail to: requester_email,
         subject: 'Resultaten screening'
  end
end
