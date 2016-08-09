class ResponsesController < ApplicationController
  def create
    invitation_accepted = AcceptInvitation.run! params.slice(:invitation_uuid)
    redirect_to response_url id: invitation_accepted.response_uuid
  end

  def show
    response = Response.find params[:id]
    render json: ResponseSerializer.new(response).as_json
  end

  def update
    response_finished = FinishResponse.run response_uuid: params[:id]
    if response_finished.valid?
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
