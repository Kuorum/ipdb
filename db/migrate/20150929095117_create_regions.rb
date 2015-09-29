class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :iso3166_2
      t.string :name

      t.timestamps null: false
    end
  end
end
