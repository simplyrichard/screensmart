module Events
  class Event < ActiveRecord::Base
    validates :type, :data, presence: true

    def self.event_attributes(attributes)
      jsonb_accessor :data, attributes
    end
  end
end
