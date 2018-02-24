class Result < ApplicationRecord
  belongs_to :goal
  has_one :reflection
  enum status: [ :success, :failure ]
  validates :date, :status, :goal_id, presence: true
end
