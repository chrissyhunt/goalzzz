class Goal < ApplicationRecord
  belongs_to :user
  has_many :results
  has_many :successes, -> { where(status: 'success') }, class_name: 'Result'
  has_many :failures, -> { where(status: 'failure') }, class_name: 'Result'
  has_many :reflections, through: :results
  enum status: [ :open, :completed ]
  enum interval: [ :daily, :weekly, :monthly ]
  enum priority: [ :high, :medium, :low ]
  validates :description, :start_date, :end_date, :interval, :user_id, presence: true

  def result_by_date(date)
    self.results.find_by(date: date)
  end

  def reflection_by_date(date)
    if self.result_by_date(date)
      self.results.find_by(date: date).reflection
    end
  end

  def percent_complete
    days_counted = (Date.tomorrow - self.start_date).to_i
    total_days = (self.end_date - self.start_date).to_i
    (days_counted.to_f/total_days.to_f)*100
  end

  def success_rate
    days_counted = (Date.tomorrow - self.start_date).to_i
    successful_days = self.successes.count
    (successful_days.to_f/days_counted.to_f)*100
  end

end
