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
    if self.interval == "daily"
      self.results.find_by(date: date)
    elsif self.interval == "weekly"
      ### return first result for week of date
      date = date.to_date
      range = (date..date+6).to_a
      results = range.collect { |date| self.results.find_by(date: date) }
      results = results - [nil]
      results.first
    else
      ### return first result for month of date
      date = date.to_date
      range = (date..date.next_month-1).to_a
      results = range.collect { |date| self.results.find_by(date: date) }
      results = results - [nil]
      results.first
    end
  end

  def reflection_by_date(date)
    if self.result_by_date(date)
      self.results.find_by(date: date).reflection
    end
  end

  def percent_complete
    days_counted = (Date.today - self.start_date + 1).to_i
    total_days = (self.end_date - self.start_date + 1).to_i
    (days_counted.to_f/total_days.to_f)*100
  end

  def success_rate
    days_counted = (Date.today - self.start_date + 1).to_i
    successful_days = self.successes.count
    (successful_days.to_f/days_counted.to_f)*100
  end

  def current_success_streak
    last_date = nil
    successes_by_date = self.success.sort_by { |result| result.date }.reverse

    successes_by_date.each_with_index do |result, index|
      if last_date && last_date != result.date + 1
        current_streak = index
        break
      end
      last_date = result.date
    end

    current_streak
  end

  # def current_success_streak
  #   reversed_results_by_date = self.results.sort_by { |result| result.date }.reverse
  #   current_streak = 0
  #   last_date = nil
  #
  #   reversed_results_by_date.each do |result|
  #     if result.status == "success"
  #       if last_date == nil || last_date == (result.date + 1)
  #         current_streak += 1
  #         last_date = result.date
  #       end #close 2nd conditional
  #     else
  #       break
  #     end #close 1st conditional
  #   end #close loop
  #   current_streak
  # end #close method
  #
  # def update_longest_streak
  #   if self.current_success_streak > self.longest_streak
  #     self.longest_streak = self.current_success_streak
  #     self.save
  #   end
  # end

end
