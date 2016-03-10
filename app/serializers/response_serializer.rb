class ResponseSerializer < ActiveModel::Serializer
  attributes :estimate, :variance, :questions

  def questions
    questions = object.answers.map do |key, value|
      Question.find_by_key(key).as_json.merge(
        answer: value
      )
    end
    questions << Question.find_by_key(object.next_question_key)
  end
end
