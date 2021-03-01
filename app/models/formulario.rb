class Formulario < ApplicationRecord
  include SelectConcern

  def full_titulo
    <<~HTML
      #{titulo}
    HTML
  end
end
