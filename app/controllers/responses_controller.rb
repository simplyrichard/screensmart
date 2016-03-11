class ResponsesController < ApplicationController
  def create
    @response = Response.new(answers: params[:answers],
                             old_estimate: params[:old_estimate],
                             old_variance: params[:old_variance])
    render json: ResponseSerializer.new(@response).as_json
  end
end
