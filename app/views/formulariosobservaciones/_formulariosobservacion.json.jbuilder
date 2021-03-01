json.extract! formulariosobservacion, :id, :formulario_id, :title, :observation, :created_at, :updated_at
json.url formulariosobservacion_url(formulariosobservacion, format: :json)
