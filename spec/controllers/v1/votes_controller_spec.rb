require "spec_helper"

describe V1::VotesController do
  let(:entry) { double }
  let(:user) { double }

  before do
    controller.stub(current_user: user)
    Entry.stub(find: entry)
  end

  describe "#create" do
    it "votes for an entry" do
      controller.send(:current_user).should_receive(:vote_exclusively_for).with(entry)
      post :create, entry_id: 1, upvote: true
    end

    it "votes against an entry" do
      controller.send(:current_user).should_receive(:vote_exclusively_against).with(entry)
      post :create, entry_id: 1, upvote: false
    end
  end
end
