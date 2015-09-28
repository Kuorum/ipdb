class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :sourceWebsite
      t.string :name
      t.string :picture
      t.string :politicalParty
      t.string :politicalPartyImage
      t.string :verified
      t.integer :likes
      t.integer :followers
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :linkedin
      t.string :googlePlus
      t.string :instagram
      t.string :blog
      t.string :youtubeChannel
      t.string :premium
      t.text :bio
      t.text :quote1
      t.text :quote2
      t.string :sourceActivity
      t.text :lastActivity1
      t.text :lastActivity2
      t.text :lastActivity3
      t.text :lastActivity4
      t.integer :ideology1
      t.integer :ideology2
      t.integer :ideology3
      t.integer :ideology4
      t.integer :ideology5
      t.integer :following
      t.integer :openProjects
      t.integer :closedProjects
      t.integer :proposals
      t.integer :debates
      t.integer :sponsorships
      t.integer :victories
      t.string :dateOfBirth
      t.string :placeOfBirth
      t.text :institutionalAddress
      t.string :institutionalTelephone
      t.string :institutionalFax
      t.string :institutionalMobilePhone
      t.string :electoralAddress
      t.string :electoralTelephone
      t.string :electoralFax
      t.string :electoralMobile
      t.string :phone
      t.string :assistants
      t.string :completeName
      t.string :position
      t.string :region
      t.string :institution
      t.string :constituency
      t.string :studies
      t.string :university
      t.string :profession
      t.string :cvLink
      t.string :declarationLink
      t.string :officialWebsite

      t.timestamps null: false
    end
  end
end
