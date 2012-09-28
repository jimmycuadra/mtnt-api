require "spec_helper"

describe V1::EntriesController do
  let(:params) { HashWithIndifferentAccess.new({ noun: "foo", needs: true, verb: "bar" }) }
  let(:entry) { stub }
  let(:user) do
    u = stub
    u.stub(id: 1)
    u
  end

  before { controller.stub(:current_user).and_return(user) }

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
    it "creates a new entry for the user" do
      Entry.should_receive(:build).with(params).and_return(entry)
      entry.should_receive(:user=).with(user)
      entry.should_receive(:save)
      post :create, entry: params
    end
  end

  describe "#update" do
    it "updates a user's existing entry" do
      Entry.should_receive(:find_by_id_and_user_id).with("1", user.id).and_return(entry)
      entry.should_receive(:update_attributes).with(params)
      put :update, id: "1", entry: params
    end
  end

  describe "#destroy" do
    it "destroys a user's existing entry" do
      Entry.should_receive(:find_by_id_and_user_id).with("1", user.id).and_return(entry)
      entry.should_receive(:destroy)
      delete :destroy, id: "1"
    end
  end
end
