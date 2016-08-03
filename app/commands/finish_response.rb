class FinishResponse < ActiveInteraction::Base
  string :response_uuid

  validates :response_uuid, presence: true
  validate :validate_response_uuid_is_found

  def execute
    invitation_accepted = Events::InvitationAccepted.find_by(response_uuid: response_uuid)

    Events::ResponseFinished.create! invitation_uuid: invitation_accepted.invitation_uuid,
                                     response_uuid: response_uuid
  end

  def validate_response_uuid_is_found
    return if Response.exists? response_uuid
    errors.add(:response_uuid, 'is unknown')
  end
end
