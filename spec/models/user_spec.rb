require "spec_helper"

describe User do
  it "requires a name" do
    subject.valid?
    expect(subject).to have(1).error_on(:name)
  end

  it "has many entries" do
    expect(subject).to respond_to(:entries)
  end
end
