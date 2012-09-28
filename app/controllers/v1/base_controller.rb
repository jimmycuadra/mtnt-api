class V1::BaseController < ActionController::Base
  private

  def current_user
    Thread.current[:current_user] ||= User.find_by_api_key(params[:api_key])
  end
end
