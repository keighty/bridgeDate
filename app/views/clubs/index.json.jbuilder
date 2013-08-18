json.array!(@clubs) do |club|
  json.extract! club, :name, :address, :city, :state, :zip
  json.url club_url(club, format: :json)
end
