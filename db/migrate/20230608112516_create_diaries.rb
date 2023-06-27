class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.date :date, null: false
      t.integer :sbp
      t.integer :dbp
      t.float :bt
      t.float :weight
      t.text :exercise
    end
  end
end
