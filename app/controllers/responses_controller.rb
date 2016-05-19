class ResponsesController < ApplicationController
  wrap_parameters Response, format: :json

  def create
    @response = Response.new(convert_response_params)
    render json: ResponseSerializer.new(@response).as_json
  rescue ActionController::ParameterMissing
    head :unprocessable_entity
  end

  private

  # TODO: update model to be equal to the model used by clientside so this conversion is unneccesary
  def convert_response_params
    {
      answer_values: response_params['questions'].each_with_object({}) do |question, memo|
        memo[question['key']] = question['answer_value']
      end
    }
  end

  def response_params
    params.require(:response).permit(questions: [:key, :answer_value]).tap do |whitelisted|
      required_question_attributes = [:key, :answer_value]

      whitelisted[:questions] ||= []
      whitelisted[:questions].each do |question|
        required_question_attributes.each do |attribute|
          raise ActionController::ParameterMissing, questions: [attribute] unless question[attribute].present?
        end
      end
    end
  end
end
