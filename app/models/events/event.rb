module Events
  class Event < ActiveRecord::Base
    validates :type, :data, presence: true

    jsonb_accessor :data

    def self.event_attributes(attributes)
      jsonb_accessor :data, attributes

      attributes.each do |attribute, _|
        define_singleton_method "find_by_#{attribute}" do |value|
          records = send("with_#{attribute}", value)
          raise "Expected to find one #{self}, got #{records.count}" unless records.count == 1
          records.first
        end
      end
    end
  end
end
