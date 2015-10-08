class CreatePoliticalParties < ActiveRecord::Migration
  def change
    create_table :political_parties do |t|
      t.string :name
      t.decimal :leaning_index, :decimal, :precision=>64, :scale=>12

      t.timestamps null: false
    end
  end
end
