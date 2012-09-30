require "spec_helper"

describe V1::SessionsController do
  describe "#create" do
    it "responds with a new session" do
      User.should_receive(:find_or_create_with_persona).with("abcdefg")
      post :create, assertion: "abcdefg"
    end

    it "returns an error if the Persona assertion could not be verified" do
      User.stub(:find_or_create_with_persona).and_raise(User::AssertionVerificationFailed)
      post :create, assertion: "abcdefg"
      expect(response.code.to_i).to eql(400)
    end
  end
end
