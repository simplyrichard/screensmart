module Events
  class AdhocResponseStarted < Event
    event_attributes domain_ids: :string_array,
                     show_secret: :string
  end
end
