require "spec_helper"

describe V1::EntriesController do
  describe "#index" do
    it "lists the newest entries" do
      Entry.should_receive(:newest)
      get :index
    end
  end

  describe "#show" do
    it "shows an individual entry" do
      Entry.should_receive(:find).with("1")
      get :show, id: "1"
    end
  end

  describe "#create" do
    let(:entry) { stub }
    let(:user) { stub }
    let(:params) { HashWithIndifferentAccess.new({ noun: "foo", needs: true, verb: "bar" }) }

    before { controller.stub(:current_user).and_return(user) }

    it "creates a new entry for the user" do
      Entry.should_receive(:build).with(params).and_return(entry)
      entry.should_receive(:user=).with(user)
      entry.should_receive(:save)
      post :create, entry: params
    end
  end
end
