# A stateless response to a given set of questions.
# Initializing is done by setting answer_values as a hash, for example:
#   r = Response.new(answer_values: { 'EL02' => 1 })
#
# After this, all attributes can be read in an OOP way, for example:
#   r.questions # All questions, including the next (unanswered) one
#   # => [#<Question:0x007faadb3459a8 @id="EL02", @answer_value: 1>,
#         #<Question:0x007faadb2d49d8 @id="EL03">]
class Response < BaseModel
  include Events
  attr_accessor :uuid

  # Response can either be created by accepting an invitation or starting a adhoc response
  EVENT_TYPES_THAT_CAN_CREATE_IT = [Events::InvitationAccepted, Events::AdhocResponseStarted].freeze

  # Accessors for attributes defined by events
  delegate :show_secret, to: :invitation_sent
  delegate :created_at, to: :event_that_created_it

  # accessors for attributes defined by R package
  %i( next_question_id estimate variance done ).each do |r_attribute|
    define_method r_attribute do
      ensure_valid do
        RPackage.data_for(answer_values, domain_ids)[r_attribute]
      end
    end
  end

  def questions
    next_question.present? ? completed_questions.push(next_question) : completed_questions
  end

  def completed_questions
    answers.map(&:question)
  end

  def answers
    answer_values.map do |id, value|
      Answer.new id: id, value: value
    end
  end

  def answer_values
    Events::AnswerSet.answer_values_for(uuid)
  end

  def next_question
    Question.new id: next_question_id unless done
  end

  def invitation
    Invitation.find_by_response_uuid uuid
  end

  def domain_ids
    if adhoc?
      event_that_created_it.domain_ids
    else
      invitation_sent.domain_ids
    end
  end

  def adhoc?
    event_that_created_it.is_a? Events::AdhocResponseStarted
  end

  def event_that_created_it
    Events::Event.find_by response_uuid: uuid,
                          type: EVENT_TYPES_THAT_CAN_CREATE_IT
  end

  def events
    Events::Event.where response_uuid: uuid
  end

  def self.find_by_show_secret(show_secret)
    invitation_accepted = Events::Event.where(type: EVENT_TYPES_THAT_CAN_CREATE_IT).jsonb_contains(show_secret: show_secret).first || raise("Couldn't find #{self} with show_secret #{show_secret}")
    find invitation_accepted.response_uuid
  end
end
