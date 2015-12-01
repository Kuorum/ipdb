class AddCausesToData < ActiveRecord::Migration
  def change
    add_column :data, :cause6, :string
  end
end
