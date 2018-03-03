module GoalsHelper

  def generate_date_range(start_date, end_date, interval)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
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
  
end
