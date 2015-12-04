class AddPartyPermissionToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :party_permission, :text
  end
end
