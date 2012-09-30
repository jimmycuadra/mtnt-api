class Session
  PERSONA_VERIFICATION_URL = "https://verifier.login.persona.org/verify"

  class AssertionVerificationFailed < StandardError; end

  class << self
    def create(assertion)
      result = verify_assertion(assertion)

      if result["status"] == "okay"
        User.find_or_create_by_email(result["email"])
      else
        raise AssertionVerificationFailed.new(result["reason"])
      end
    end

    private

    def verify_assertion(assertion)
      response = Faraday.post(
        PERSONA_VERIFICATION_URL,
        assertion: assertion,
        audience: "http://#{MtntApi::APP_BASE_URL}"
      )

      MultiJson.load(response.body)
    end
  end
end
