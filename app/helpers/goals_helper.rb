module GoalsHelper

  def generate_date_range(start_date, end_date, interval)
    start_date = start_date.to_date
    end_date = end_date.to_date
    date_range = start_date..end_date
    all_dates = []

    date_range.each do |date|
      if interval == "monthly"
        all_dates << date if date.mday == 1
      elsif interval == "weekly"
        all_dates << date if date.wday == 1
      else
        all_dates << date
      end
    end

    all_dates
  end

  def goals_by_priority(user, priority, completed=false)
    if completed
      Goal.completed.select { |g| g.user_id == user.id && g.priority == priority }
    else
      user.goals.where(priority: priority)
    end
  end

  def goal_intervals
    Goal.intervals.keys
  end

  def goal_priorities
    Goal.priorities.keys
  end

end
