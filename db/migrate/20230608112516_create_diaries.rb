class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|

      t.timestamps
      t.date :date, null: false
      t.integer :bp, null: false
      t.integer :bt, null: false
      t.integer :weight, null: false
      t.text :exercise, null: false
    end
  end
end
