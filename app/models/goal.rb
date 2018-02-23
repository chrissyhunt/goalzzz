class Goal < ApplicationRecord
  belongs_to :user
  has_many :results
  has_many :reflections, through: :results
  enum status: [ :open, :completed ]
  enum interval: [ :daily, :weekly, :monthly ]
  enum priority: [ :high, :medium, :low ]
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :interval, presence: true
end
