class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :position
      t.float :lat
      t.float :lng
      t.timestamps
    end
  end
end
