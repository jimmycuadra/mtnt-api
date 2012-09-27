class Entry < ActiveRecord::Base
  attr_accessible :needs, :noun, :verb

  belongs_to :user

  before_validation :strip_whitespace

  validates :needs, inclusion: { in: [true, false] }
  validates :noun, presence: true
  validates :verb, presence: true
  validates :user_id, presence: true

  def strip_whitespace
    self.noun = noun.strip! if noun.present?
    self.verb = verb.strip! if verb.present?
  end
end
