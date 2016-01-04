class ChangeActivity5ToText < ActiveRecord::Migration
  def up
  	change_column(:data, :lastActivity5, :text)
  end

  def down
  	change_column(:data, :lastActivity5, :string)
  end
end
