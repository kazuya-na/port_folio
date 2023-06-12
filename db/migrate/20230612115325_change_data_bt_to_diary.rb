class ChangeDataBtToDiary < ActiveRecord::Migration[6.1]
  def change
    change_column :diaries, :bt, :float
  end
end
