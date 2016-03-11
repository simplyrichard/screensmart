class Question
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :key, :text, :answer_option_set

  def self.find_by_key(key)
    all.detect { |question| question.key == key } || raise("question `#{key}` not found")
  end

  def self.parse(raw_question)
    new \
      key:  raw_question['key'],
      text: raw_question['text'],
      answer_option_set: AnswerOptionSet.new(
        id: raw_question['answer_option_set_id'],
        answer_options: raw_question['answer_options'].map do |raw_answer_option|
          AnswerOption.new(value: raw_answer_option['value'], text: raw_answer_option['text'])
        end
      )
  end

  def self.all
    RPackage.questions.map { |raw_question| parse(raw_question) }
  end
end
