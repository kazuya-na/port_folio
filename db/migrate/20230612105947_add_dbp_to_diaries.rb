class AddDbpToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :dbp, :integer
  end
end
