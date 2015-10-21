class AddPartyImageToPoliticalParties < ActiveRecord::Migration
  def change
	add_column :political_parties, :image, :text
  end
end
