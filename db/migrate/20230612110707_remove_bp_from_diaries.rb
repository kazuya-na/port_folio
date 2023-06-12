class RemoveBpFromDiaries < ActiveRecord::Migration[6.1]
  def change
    remove_column :diaries, :bp, :integer
  end
end
