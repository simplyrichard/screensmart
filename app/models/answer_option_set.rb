class AnswerOptionSet
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :id, :answer_options

  include Enumerable

  def each
    @answer_options.each do |answer_option|
      yield answer_option
    end
  end
end
