class AddPoliticalExperienceAndCausesToData < ActiveRecord::Migration
  def change
    add_column :data, :politicalExperience, :text
    add_column :data, :causes, :text
  end
end
