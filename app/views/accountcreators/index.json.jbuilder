json.array!(@users) do |user|
  json.extract! user, :id, :firstname, :lastname, :mail
  #json.url company_url(user, format: :json)
end
