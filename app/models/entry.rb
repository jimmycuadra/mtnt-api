class Entry < ActiveRecord::Base
  attr_accessible :needs, :noun, :verb

  belongs_to :user

  before_validation :strip_whitespace

  validates :needs, inclusion: { in: [true, false] }
  validates :noun, presence: true
  validates :verb, presence: true
  validates :user_id, presence: true

  def self.newest
    order("created_at desc")
  end

  def self.oldest
    order("created_at asc")
  end

  def strip_whitespace
    noun.strip! if noun.present?
    verb.strip! if verb.present?
  end
end
