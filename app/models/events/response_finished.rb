module Events
  class ResponseFinished < Event
    event_attributes estimate: :float,
                     variance: :float
  end
end
