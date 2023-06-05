class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :vital_record, null: false
    end
  end
end
