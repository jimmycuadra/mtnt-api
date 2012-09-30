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

  describe ".find_or_create_with_persona" do
    let(:response) { double.tap { |d| d.stub(:body) } }
    let(:result) { { "status" => "okay" } }

    before { MultiJson.stub(:load).and_return(result) }

    it "verifies assertions with Persona" do
      Faraday.should_receive(:post).with(
        described_class::PERSONA_VERIFICATION_URL,
        assertion: "abcdefg",
        audience: "http://#{MtntApi::APP_BASE_URL}"
      ).and_return(response)
      described_class.find_or_create_with_persona("abcdefg")
    end

    context "with a valid assertion" do
      let(:result) do
        {
          "status" => "okay",
          "email" => "starla@jade.com",
        }
      end

      it "finds or creates a user with the verified email address" do
        described_class.should_receive(:find_or_create_by_email).with("starla@jade.com")
        described_class.find_or_create_with_persona("abcdefg")
      end
    end

    context "with an invalid assertion" do
      let(:result) do
        {
          "status" => "failure",
          "reason" => "Some error message."
        }
      end

      it "raises a Session::AssertionVerificationFailed exception" do
        expect do
          described_class.find_or_create_with_persona("abcdefg")
        end.to raise_error(described_class::AssertionVerificationFailed, "Some error message.")
      end
    end
  end
end
