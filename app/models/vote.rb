class Vote < ActiveRecord::Base
  attr_accessible :vote, :voter, :voteable

  belongs_to :voteable, polymorphic: true
  belongs_to :voter, polymorphic: true

  validates :voteable_id, uniqueness: { scope: [:voteable_type, :voter_type, :voter_id] }

  scope :for_voter, ->(*args) do
    where([
      "voter_id = ? AND voter_type = ?",
      args.first.id,
      args.first.class.base_class.name
    ])
  end

  scope :for_voteable, ->(*args) do
    where([
      "voteable_id = ? AND voteable_type = ?",
      args.first.id,
      args.first.class.base_class.name
    ])
  end

  scope :recent, ->(*args) do
    where(["created_at > ?", (args.first || 2.weeks.ago)])
  end

  scope :descending, order("created_at DESC")
end
