require 'mechanize'
require 'date'
require 'time'
require 'json'
require 'rake-progressbar'


region_abbreviation = 'NA-US' #Unites States
source = 'https://www.congress.gov/'

task :scraper_test => [:environment] do

	agent = Mechanize.new

	last_page_number = 1

	for pg_number in 1..last_page_number do

	end
end