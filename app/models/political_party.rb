class PoliticalParty < ActiveRecord::Base
	belongs_to :region

	has_paper_trail
end
