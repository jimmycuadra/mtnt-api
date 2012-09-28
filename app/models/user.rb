require "securerandom"

class User < ActiveRecord::Base
  attr_accessible :name

  has_many :entries

  validates :name, presence: true
  validates :api_key, presence: true

  acts_as_voter

  def generate_api_key!
    self.api_key = SecureRandom.uuid
  end
end
