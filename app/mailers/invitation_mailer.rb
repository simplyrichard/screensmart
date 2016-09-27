class InvitationMailer < ApplicationMailer
  def invitation_email(requester_email:, respondent_email:, invitation_uuid:)
    @requester_email = requester_email
    @link = fill_out_url(invitationUUID: invitation_uuid)

    mail to: respondent_email,
         subject: 'Verzoek om vragenlijst in te vullen'
  end
end
