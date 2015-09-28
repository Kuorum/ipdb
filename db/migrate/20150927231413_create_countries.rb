class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :abbreviation
      t.string :source
      t.boolean :scraped, :default => false

      t.timestamps null: false
    end
  end
end
