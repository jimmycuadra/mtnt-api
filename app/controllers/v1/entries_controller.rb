class V1::EntriesController < V1::BaseController
  respond_to :json

  def index
    entries = case params[:order]
    when "oldest"
      Entry.oldest
    else
      Entry.newest
    end

    respond_with entries.paginate(page: params[:page] || 1, per_page: params[:per_page] || 30)
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
