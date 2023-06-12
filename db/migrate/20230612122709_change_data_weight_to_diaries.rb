class ChangeDataWeightToDiaries < ActiveRecord::Migration[6.1]
  def change
    change_column :diaries, :weight, :float
  end
end
