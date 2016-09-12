json.extract! event, :id, :summary, :location, :description, :start_time, :end_time, :created_at, :updated_at
json.url event_url(event, format: :json)