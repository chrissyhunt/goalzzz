class CreateReflections < ActiveRecord::Migration[5.1]
  def change
    create_table :reflections do |t|
      t.string :content
      t.integer :result_id
      t.timestamps
    end
  end
end
