require "securerandom"

class User < ActiveRecord::Base
  PERSONA_VERIFICATION_URL = "https://verifier.login.persona.org/verify"

  class AssertionVerificationFailed < StandardError; end

  attr_accessible :name

  has_many :entries

  before_validation :generate_api_key!

  validates :email, presence: true
  validates :api_key, presence: true

  acts_as_voter

  class << self
    def find_or_create_with_persona(assertion)
      result = verify_assertion(assertion)

      if result["status"] == "okay"
        find_or_create_by_email(result["email"])
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

  def generate_api_key!
    self.api_key = SecureRandom.uuid unless api_key.present?
  end
end
