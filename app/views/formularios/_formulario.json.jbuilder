# frozen_string_literal: true

json.extract! formulario, :id, :nombre, :email, :observacion, :created_at, :updated_at
json.url formulario_url(formulario, format: :json)
