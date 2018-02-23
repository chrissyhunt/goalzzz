class Result < ApplicationRecord
  belongs_to :goal
  belongs_to :user, through: :goal
  has_one :reflection
  enum status: [ :success, :failure ]
  validates :date, presence: true
  validates :status, presence: true
end
