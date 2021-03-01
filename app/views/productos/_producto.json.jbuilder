json.extract! producto, :id, :titulo, :descripcion, :created_at, :updated_at
json.url producto_url(producto, format: :json)
