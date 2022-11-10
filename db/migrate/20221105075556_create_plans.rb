class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.string :plan_name
      t.string :start_day
      t.string :end_day
      t.string :meeting_place
      t.string :meeting_time
      t.text :memo
      t.timestamps
    end
  end
end
