# == Schema Information
#
# Table name: formularios
#
#  id          :integer          not null, primary key
#  email       :string
#  nombre      :string
#  observacion :text
#  titulo      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module FormulariosUser
  class Information < FormulariosUser::ApplicationRecord
    include SelectConcern
    self.table_name = "formularios"

    attr_reader :nombre

    has_many :formulariosobservaciones
    has_many :formulariosobsusers

    def initialize(nombre)
      @nombre = nombre
    end

    def full_titulo2
      <<~HTML
      #{titulo}
      HTML
    end
  end
end
