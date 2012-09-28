class V1::VotesController < V1::BaseController
  respond_to :json

  def create
    entry = Entry.find(params[:entry_id])

    respond_with case params[:upvote]
    when true
      current_user.vote_exclusively_for(entry)
    else
      current_user.vote_exclusively_against(entry)
    end
  end
end
