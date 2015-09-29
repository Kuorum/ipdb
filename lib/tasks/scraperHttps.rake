require 'mechanize'
require 'date'
require 'json'
require 'openssl'

module OpenSSL
	module SSL
	remove_const :VERIFY_PEER
	end
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil


task :scrapeHttps do

	agent = Mechanize.new
	page = agent.get("https://www.congress.gov/members")

	page_links = page.links_with(href: %r{^/member/\w+})

	#review_links = review_links.reject do |link|
	 # parent_classes = link.node.parent['class'].split
	 # parent_classes.any? { |p| %w[next-container page-number].include?(p) }
	# end

	#page_links = page.search('.title').href

	product_links = page_links[0...2]

	products = product_links.map do |link|

	  product = link.click

	  title = product.search('title').text

	  {
	    title: title
	  }

	end

	puts JSON.pretty_generate(products)

end