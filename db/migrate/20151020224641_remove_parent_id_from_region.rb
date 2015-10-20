class RemoveParentIdFromRegion < ActiveRecord::Migration
  def change
  	remove_column :regions, :parent_id
  end
end
