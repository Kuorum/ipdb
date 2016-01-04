class AddNewsFieldsToData < ActiveRecord::Migration
  def change
    add_column :data, :news1date, :string
    add_column :data, :news2date, :string
    add_column :data, :news3date, :string
    add_column :data, :news4date, :string
    add_column :data, :news5date, :string
    add_column :data, :news1title, :text
    add_column :data, :news2title, :text
    add_column :data, :news3title, :text
    add_column :data, :news4title, :text
    add_column :data, :news5title, :text
    add_column :data, :news1content, :text
    add_column :data, :news2content, :text
    add_column :data, :news3content, :text
    add_column :data, :news4content, :text
    add_column :data, :news5content, :text
    add_column :data, :news1link, :text
    add_column :data, :news2link, :text
    add_column :data, :news3link, :text
    add_column :data, :news4link, :text
    add_column :data, :news5link, :text
    add_column :data, :news1picture, :text
    add_column :data, :news2picture, :text
    add_column :data, :news3picture, :text
    add_column :data, :news4picture, :text
    add_column :data, :news5picture, :text
  end
end
