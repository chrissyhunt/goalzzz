class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.date :date
      t.integer :status
      t.integer :goal_id
      t.timestamps
    end
  end
end
