class AddEndUserIdToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :end_user_id, :integer
  end
end
