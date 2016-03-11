class Response
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :answers, :old_estimate, :old_variance

  # accessors for attributes defined by R package
  %i( next_question_key estimate variance ).each do |r_attribute|
    define_method r_attribute do
      RPackage.data_for(answers, old_estimate, old_variance)[r_attribute]
    end
  end

  def initialize(attributes = {})
    super
    self.answers ||= {}
    self.old_estimate ||= 1.0
    self.old_variance ||= 0.5
  end

  validate :answer_values_integers

  def next_question
    Question.find_by_key next_question_key
  end

  private

  def answer_values_integers
    errors.add :answers, 'values must be integers' unless answers.values.all? { |v| v.is_a? Integer }
  end
end
