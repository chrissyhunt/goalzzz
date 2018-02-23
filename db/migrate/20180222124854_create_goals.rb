class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :description
      t.date :start_date
      t.date :end_date
      t.integer :longest_streak
      t.integer :interval
      t.integer :status
      t.integer :priority
      t.timestamps
    end
  end
end
