require "spec_helper"

describe V1::BaseController do
  controller do
    def index
      render text: current_user.id
    end
  end

  describe "#current_user" do
    it "finds the current_user using an API key" do
      user = FactoryGirl.create(:user)
      get :index, api_key: user.api_key
      expect(response.body).to eql(user.id.to_s)
    end
  end
end
