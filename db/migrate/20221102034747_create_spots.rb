class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
