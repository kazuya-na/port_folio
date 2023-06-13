class ChangeDataGenderToEndUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :end_users, :gender, :integer
  end
end
