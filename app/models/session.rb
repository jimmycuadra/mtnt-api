class Session
  PERSONA_VERIFICATION_URL = "https://verifier.login.persona.org/verify"

  class AssertionVerificationFailed < StandardError; end

  def self.create(options)
    response = Faraday.post(
      PERSONA_VERIFICATION_URL,
      assertion: options[:assertion],
      audience: "http://#{MtntApi::APP_BASE_URL}"
    )

    result = MultiJson.load(response.body)

    if result["status"] == "okay"
      User.find_or_create_by_email(result["email"])
    else
      raise AssertionVerificationFailed.new(result["reason"])
    end
  end
end
