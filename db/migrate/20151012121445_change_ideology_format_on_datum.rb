class ChangeIdeologyFormatOnDatum < ActiveRecord::Migration
  def change
  	change_column(:data, :ideology1, :decimal, :precision=>64, :scale=>12)
  	change_column(:data, :ideology2, :decimal, :precision=>64, :scale=>12)
  	change_column(:data, :ideology3, :decimal, :precision=>64, :scale=>12)
  	change_column(:data, :ideology4, :decimal, :precision=>64, :scale=>12)
  	change_column(:data, :ideology5, :decimal, :precision=>64, :scale=>12)
  end
end
