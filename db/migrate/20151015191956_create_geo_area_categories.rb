class CreateGeoAreaCategories < ActiveRecord::Migration
  def change
    create_table :geo_area_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
