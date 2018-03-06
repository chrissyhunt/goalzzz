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

  1/31, 1/30, 1/28

  def current_success_streak
    reversed_results_by_date = self.results.sort_by { |result| result.date }.reverse
    current_streak = 0
    last_date = nil

    reversed_results_by_date.each do |result|
      if result.status == "success"
        if last_date == nil || last_date == (result.date + 1)
          current_streak += 1
          last_date = result.date
        end
      else
        break
      end

    current_streak
  end

  def update_longest_streak
    if self.current_success_streak > self.longest_streak
      self.longest_streak = self.current_success_streak
      self.save
    end
  end

end
