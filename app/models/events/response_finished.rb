module Events
  class ResponseFinished < Event
    event_attributes :answer_values,
                     estimate: :float,
                     variance: :float
  end
end
