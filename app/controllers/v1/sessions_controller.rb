class V1::SessionsController < V1::BaseController
  respond_to :json

  def create
    respond_with Session.create(assertion: params[:assertion])
  end
end
