require "spec_helper"

describe Session do
  describe ".create" do
    let(:response) { double.tap { |d| d.stub(:body) } }
    let(:result) { { "status" => "okay" } }

    before { MultiJson.stub(:load).and_return(result) }

    it "verifies assertions with Persona" do
      Faraday.should_receive(:post).with(
        Session::PERSONA_VERIFICATION_URL,
        assertion: "abcdefg",
        audience: "http://#{MtntApi::APP_BASE_URL}"
      ).and_return(response)
      Session.create(assertion: "abcdefg")
    end

    context "with a valid assertion" do
      let(:result) do
        {
          "status" => "okay",
          "email" => "starla@jade.com",
        }
      end

      it "returns a User session" do
        Session.should_receive(:new).with(email: "starla@jade.com")
        Session.create(assertion: "abcdefg")
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
          Session.create(assertion: "abcdefg")
        end.to raise_error(Session::AssertionVerificationFailed, "Some error message.")
      end
    end
  end
end
