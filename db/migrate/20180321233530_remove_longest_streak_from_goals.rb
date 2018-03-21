class RemoveLongestStreakFromGoals < ActiveRecord::Migration[5.1]
  def change
    remove_column :goals, :longest_streak
  end
end
