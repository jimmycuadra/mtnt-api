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

  def update
    entry = Entry.find_by_id_and_user_id(params[:id], current_user.id)
    respond_with entry.update_attributes(params[:entry])
  end

  def destroy
    entry = Entry.find_by_id_and_user_id(params[:id], current_user.id)
    respond_with entry.destroy
  end
end
