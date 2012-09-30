class V1::SessionsController < V1::BaseController
  respond_to :json

  def create
    user = begin
      User.find_or_create_with_persona(params[:assertion])
    rescue
      return head :bad_request
    end

    respond_with user
  end
end
