json.array!(@regions) do |region|
  json.extract! region, :id, :iso3166_2, :name
  json.url region_url(region, format: :json)
end
