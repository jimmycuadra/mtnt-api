require "spec_helper"

describe User do
  [:email].each do |attribute|
    it "requires the #{attribute} attribute" do
      subject.valid?
      expect(subject).to have(1).error_on(attribute)
    end
  end

  it "has many entries" do
    expect(subject).to respond_to(:entries)
  end

  describe "#generate_api_key!" do
    it "generates a UUID to use as the user's API key" do
      subject.generate_api_key!
      expect(subject.api_key).to match(/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/)
    end
  end

  it "can vote on entries" do
    expect(subject).to respond_to(:vote_for)
  end
end
