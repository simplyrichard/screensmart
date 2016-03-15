class ResponsesController < ApplicationController
  def create
    @response = Response.new(response_params)
    render json: ResponseSerializer.new(@response).as_json
  end

  def response_params
    params.permit(:old_estimate, :old_variance).merge(answers: params[:answers])
  end
end
