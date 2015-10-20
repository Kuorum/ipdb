class ChangeLeaningIndexOnData < ActiveRecord::Migration
  def change
  	  	change_column(:data, :political_leaning_index, :decimal, :precision=>64, :scale=>12)
  end
end
