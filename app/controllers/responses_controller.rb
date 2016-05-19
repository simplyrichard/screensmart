class ResponsesController < ApplicationController
  wrap_parameters Response, format: :json

  def create
    @response = Response.new(convert_response_params)
    render json: ResponseSerializer.new(@response).as_json
  end

  private

  # TODO: update model to be equal to the model used by clientside so this conversion is unneccesary
  def convert_response_params
    return unless response_params.try(:[], 'questions').present?

    {
      answer_values: response_params['questions'].each_with_object({}) do |question, memo|
        memo[question['key']] = question['answer_value']
      end
    }
  end

  def response_params
    return unless params[:response].present?

    params.require(:response).permit(questions: [:key, :answer_value])
  end
end
