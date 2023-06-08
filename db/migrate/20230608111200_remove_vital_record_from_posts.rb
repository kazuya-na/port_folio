class RemoveVitalRecordFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :vital_record, :string
  end
end
