class AcceptInvitation < ActiveInteraction::Base
  string :invitation_uuid

  validates :invitation_uuid, presence: true
  validate :validate_response_has_not_been_finished

  def execute
    Events::InvitationAccepted.create! invitation_uuid: invitation_uuid,
                                       response_uuid: SecureRandom.uuid
  end

  def validate_response_has_not_been_finished
    return unless Events::ResponseFinished.find_by(invitation_uuid: invitation_uuid)
    errors.add(:invitation_uuid, 'has already been finished')
  end
end
