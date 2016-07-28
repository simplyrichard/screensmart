module Events
  class InvitationAccepted < Event
    event_attributes response_uuid: :string
  end
end
