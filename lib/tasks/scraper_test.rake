require 'mechanize'

task :scraper_test => [:environment] do

	agent = Mechanize.new

	page = agent.get("https://www.camara.cl/camara/diputado_detalle.aspx?prmid=968")

	form = page.form("aspnetForm")
	form.add_field!('ctl00$mainPlaceHolder$btnSala','')
	tab = agent.submit(form)

	date1 = tab.search('tr:nth-child(1) td:nth-child(1)').text.strip
	content1 = tab.search('tr:nth-child(1) td:nth-child(3)').text.strip

	puts "#{date1} | #{content1}"

end