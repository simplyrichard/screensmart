class AcceptInvitation < ActiveInteraction::Base
  string :invitation_uuid

  validates :invitation_uuid, presence: true

  def execute
    Events::InvitationAccepted.create! invitation_uuid: invitation_uuid,
                                       response_uuid: SecureRandom.uuid
  end
end
