module Events
  class InvitationAccepted < Event
    # No event attributes, invitation_uuid + response_uuid columns are enough
    event_attributes show_secret: :string

    def self.find_by_show_secret(show_secret)
      with_show_secret(show_secret).first || raise("Couldn't find #{self} with show_secret #{show_secret}")
    end
  end
end
