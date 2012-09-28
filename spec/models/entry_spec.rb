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

  it "strips leading and trailing whitespace from nouns and verbs" do
    subject.noun = " foo "
    subject.verb = " bar "
    subject.valid?
    expect(subject.noun).to eql("foo")
    expect(subject.verb).to eql("bar")
  end

  describe ".newest" do
    it "lists the newest entries" do
      e1 = FactoryGirl.create(:entry, created_at: Time.now)
      e2 = FactoryGirl.create(:entry, created_at: 1.day.ago)
      e3 = FactoryGirl.create(:entry, created_at: 1.week.ago)

      expect(Entry.newest.map(&:id)).to eql([e1, e2, e3].map(&:id))
    end
  end

  describe ".oldest" do
    it "lists the oldest entries" do
      e1 = FactoryGirl.create(:entry, created_at: Time.now)
      e2 = FactoryGirl.create(:entry, created_at: 1.day.ago)
      e3 = FactoryGirl.create(:entry, created_at: 1.week.ago)

      expect(Entry.oldest.map(&:id)).to eql([e3, e2, e1].map(&:id))
    end
  end

  it "can be voted on by users" do
    expect(subject).to respond_to(:votes)
  end
end
