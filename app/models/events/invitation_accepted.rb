module Events
  class InvitationAccepted < Event
    event_attributes invitation_uuid: :string,
                     response_uuid: :string
  end
end
