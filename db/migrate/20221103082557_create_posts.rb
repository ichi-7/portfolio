class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :spot_id
      t.string :title
      t.text :info
      t.timestamps
    end
  end
end
