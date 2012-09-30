require "spec_helper"

describe Session do
  describe ".create" do
    let(:response) { double.tap { |d| d.stub(:body) } }
    let(:result) { {} }

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
          "audience" => "http://#{MtntApi::APP_BASE_URL}",
          "expires" => "ms since epoch",
          "issuer" => "Mozilla Persona"
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

      it "returns a session with an error" do
        Session.should_receive(:new).with(error: "Some error message.")
        Session.create(assertion: "abcdefg")
      end
    end
  end
end
