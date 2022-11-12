class CreateGroupChats < ActiveRecord::Migration[6.1]
  def change
    create_table :group_chats do |t|
      t.integer :user_id
      t.integer :plan_id
      t.text :message
      t.timestamps
    end
  end
end
