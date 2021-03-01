# frozen_string_literal: true

json.extract! pagina, :id, :titulo, :created_at, :updated_at
json.url pagina_url(pagina, format: :json)
