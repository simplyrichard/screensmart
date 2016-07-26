class Invitation < BaseModel
  attr_accessor :uuid

  def domain_ids
    invitation_sent.domain_ids
  end

  def invitation_sent
    Events::InvitationSent.find_by_invitation_uuid uuid
  end

  def self.find_by_response_uuid(response_uuid)
    invitation_accepted = Events::InvitationAccepted.find_by! response_uuid: response_uuid
    find invitation_accepted.invitation_uuid
  end

  def self.find(uuid)
    new uuid: uuid
  end
end
