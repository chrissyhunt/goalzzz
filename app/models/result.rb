class Result < ApplicationRecord
  belongs_to :goal
  has_many :reflections
  accepts_nested_attributes_for :reflections
  enum status: [ :success, :failure ]
  validates :date, :status, :goal_id, presence: true
  validates :date, uniqueness: { scope: :goal_id, message: "result already exists for this goal" }
  
end
