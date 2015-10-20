class AddGenderToData < ActiveRecord::Migration
  def change
  	  add_column :data, :gender, :text
  end
end
