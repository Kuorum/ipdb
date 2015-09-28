json.array!(@countries) do |country|
  json.extract! country, :id, :name, :abbreviation, :source, :scraped
  json.url country_url(country, format: :json)
end
