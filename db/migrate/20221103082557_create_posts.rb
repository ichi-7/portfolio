class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :spot_id
      t.string :title
      t.text :info
      t.decimal :score, precision: 5, scale: 3
      t.timestamps
    end
  end
end
