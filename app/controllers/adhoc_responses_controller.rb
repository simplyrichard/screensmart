class AdhocResponsesController < ApplicationController
  def create
    response_created = StartAdhocResponse.run! params.slice(:domain_ids)
    redirect_to response_url id: response_created.response_uuid
  end
end
