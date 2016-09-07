json.extract! user, :id, :name_id, :pass, :name, :created_at, :updated_at
json.url user_url(user, format: :json)