class ResponseValidator < ActiveModel::Validator
  def validate(response)
    @response = response # to prevent parameter duplication

    validate_old_estimate
    validate_old_variance
    validate_answers_integers
  end

  private

  def validate_old_estimate
    return if @response.old_estimate.nil?
    valid_range = -20.0..20.0
    unless in_float_range?(@response.old_estimate, valid_range)
      @response.errors.add :old_estimate, invalid_float_message(@response.old_estimate, valid_range)
    end
  end

  def validate_old_variance
    return if @response.old_variance.nil?
    valid_range = 0.0..25.0
    unless in_float_range?(@response.old_variance, valid_range)
      @response.errors.add :old_variance, invalid_float_message(@response.old_variance, valid_range)
    end
  end

  def invalid_float_message(given_value, valid_range)
    "must be a float between #{valid_range}, #{given_value} given"
  end

  def in_float_range?(value, valid_range)
    valid_float_string?(value) && valid_range.include?(value.to_f)
  end

  # based on http://stackoverflow.com/a/1034499/2552895
  def valid_float_string?(value)
    Float(value)
  rescue
    false
  end

  def validate_answers_integers
    non_integer_answers = @response.answers.values.select do |value|
      value.to_f.to_s == value
    end

    if non_integer_answers.present?
      @response.errors.add :answers, "Answers values must all be integers, non-integers: #{non_integer_answers}"
    end
  end
end
