class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.integer :post_id, null: false
      t.text :body, null: false
    end
  end
end
