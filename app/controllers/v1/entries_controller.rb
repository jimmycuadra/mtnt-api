class V1::EntriesController < V1::BaseController
  respond_to :json

  def index
    respond_with Entry.newest
  end

  def show
    respond_with Entry.find(params[:id])
  end

  def create
    entry = Entry.build(params[:entry])
    entry.user = current_user
    entry.save
    respond_with entry
  end
end
