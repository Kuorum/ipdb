json.array!(@geo_area_categories) do |geo_area_category|
  json.extract! geo_area_category, :id
  json.url geo_area_category_url(geo_area_category, format: :json)
end
