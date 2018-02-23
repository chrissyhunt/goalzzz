class ChangeStatusInGoals < ActiveRecord::Migration[5.1]
  def change
    change_column :goals, :status, :integer, :default => 0
  end
end
