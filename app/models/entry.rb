class Entry < ActiveRecord::Base
  attr_accessible :needs, :noun, :verb

  belongs_to :user

  validates :needs, inclusion: { in: [true, false] }
  validates :noun, presence: true
  validates :verb, presence: true
  validates :user_id, presence: true
end
