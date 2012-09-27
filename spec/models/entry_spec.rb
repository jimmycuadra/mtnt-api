require "spec_helper"

describe Entry do
  [:needs, :noun, :verb, :user_id].each do |attribute|
    it "requires the #{attribute} attribute" do
      subject.valid?
      expect(subject).to have(1).error_on(attribute)
    end
  end

  describe "#needs" do
    it "must be a boolean" do
      subject.needs = true
      expect(subject).to have(0).errors_on(:needs)
      subject.needs = false
      expect(subject).to have(0).errors_on(:needs)
    end
  end

  it "belongs to a user" do
    expect(subject).to respond_to(:user)
  end
end
