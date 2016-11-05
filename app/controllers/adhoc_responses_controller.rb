class AdhocResponsesController < ApplicationController
  def create
    response_created = StartAdhocResponse.run! adhoc_response_params
    redirect_to response_url id: response_created.response_uuid
  end

  private

  def adhoc_response_params
    params.require(:adhoc_response).permit(:domain_ids)
  end
end
