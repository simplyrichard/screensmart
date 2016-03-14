class ResponseValidator < ActiveModel::Validator
  def validate(record)
    validate_answers_integers(record)
  end

  def validate_answers_integers(record)
    non_integer_answers = record.answers.select do |_, value|
      value.to_i.to_s == value
    end

    if non_integer_answers.present?
      record.errors.add :answers, "Answers values must all be integers, non-integers: #{non_integer_answers}"
    end
  end
end
