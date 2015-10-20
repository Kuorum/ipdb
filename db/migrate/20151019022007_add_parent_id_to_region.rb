class AddParentIdToRegion < ActiveRecord::Migration
  def change
  	add_column :regions, :parent_id, :integer
  end
end
