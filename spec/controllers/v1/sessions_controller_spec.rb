require "spec_helper"

describe V1::SessionsController do
  describe "#create" do
    it "responds with a new session" do
      Session.should_receive(:create).with(assertion: "abcdefg")
      post :create, assertion: "abcdefg"
    end
  end
end
