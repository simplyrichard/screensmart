class Response
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Validations
  attr_accessor :answers, :old_estimate, :old_variance

  # TODO accept string inputs but they should be castable to float
  validates :old_estimate, numericality: { only_float: true },
                           inclusion:    { in: -1.0..1.0 }

  validates :old_variance, numericality: { only_float: true },
                           inclusion:    { in: 0.0..1.0 }

  validate :answer_values_integers

  # accessors for attributes defined by R package
  %i( next_question_key estimate variance ).each do |r_attribute|
    define_method r_attribute do
      if valid?
        RPackage.data_for(answers, old_estimate, old_variance)[r_attribute]
      else
        raise "Response must be valid when accessing `#{r_attribute}`.\n" \
              "Errors: #{errors.full_messages}"
      end
    end
  end

  def initialize(attributes = {})
    super
    self.answers      ||= {}
    self.old_estimate ||= 1.0
    self.old_variance ||= 0.5
  end

  def next_question
    Question.find_by_key next_question_key
  end

  private

  def answer_values_integers
    non_integer_values = answers.select do |_, value|
      value.to_i.to_s != value
    end

    if non_integer_values.present?
      errors.add :answers, "values must all be integers, non-integers: #{non_integer_values}"
    end
  end
end
