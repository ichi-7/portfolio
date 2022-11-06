class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.integer :plan_id
      t.string :address
      t.float :lat
      t.float :lng
      t.timestamps
    end
  end
end
