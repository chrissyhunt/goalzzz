class Result < ApplicationRecord
  belongs_to :goal
  has_one :reflection
  accepts_nested_attributes_for :reflection
  enum status: [ :success, :failure ]
  validates :date, :status, :goal_id, presence: true
end
