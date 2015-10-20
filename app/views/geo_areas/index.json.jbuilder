json.array!(@geo_areas) do |geo_area|
  json.extract! geo_area, :id
  json.url geo_area_url(geo_area, format: :json)
end
