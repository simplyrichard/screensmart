module Events
  class InvitationAccepted < Event
    event_attributes show_secret: :string
  end
end
