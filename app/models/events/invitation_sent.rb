module Events
  class InvitationSent < Event
    event_attributes requester_email: :string,
                     domain_ids: :string_array,
                     invitation_uuid: :string
  end
end
