class AddLastActivityLinkToData < ActiveRecord::Migration
  def change
  	add_column :data, :lastActivity1Link, :text
  	add_column :data, :lastActivity2Link, :text
  	add_column :data, :lastActivity3Link, :text
  	add_column :data, :lastActivity4Link, :text
  	add_column :data, :lastActivity5Link, :text
  end
end
