class CreateGeoAreas < ActiveRecord::Migration
  def change
    create_table :geo_areas do |t|
      t.string :name
      t.string :code
      t.integer :category
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
