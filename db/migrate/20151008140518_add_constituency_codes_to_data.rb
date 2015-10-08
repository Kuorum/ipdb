class AddConstituencyCodesToData < ActiveRecord::Migration
  def change
    add_column :data, :constituency_code_alliance, :string
    add_column :data, :constituency_code_nation, :string
    add_column :data, :constituency_code_state, :string
    add_column :data, :constituency_code_county, :string
    add_column :data, :constituency_code_city, :string
  end
end
