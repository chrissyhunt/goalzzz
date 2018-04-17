class Result < ApplicationRecord
  enum status: [ :success, :failure ]

  belongs_to :goal
  has_many :reflections

  validates :date, :status, :goal_id, presence: true
  validates :date, uniqueness: { scope: :goal_id, message: "result already exists for this goal" }

  accepts_nested_attributes_for :reflections

  # def reflections_attributes=(reflections_attributes)
  #   reflections_attributes.each do |reflection_attributes|
  #     self.reflections.build(reflection_attributes)
  #   end
  # end
end
