class AddSbpToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :sbp, :integer
  end
end
