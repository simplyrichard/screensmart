class AppController < ApplicationController
  respond_to :html

  def index
    @initial_response = Response.new
  end
end
