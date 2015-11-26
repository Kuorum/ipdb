class AddSupervisorToUser < ActiveRecord::Migration
  def change
    add_column :users, :supervisor, :integer
  end
end
