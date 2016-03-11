class AnswerOption
  include ActiveModel::Model
  include ActiveModel::Serialization
  attr_accessor :value, :text
end
