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
module FormularioProducto
  class Account < FormularioProducto::ApplicationRecord
    include SelectConcern
    self.table_name = "formularios"

    attr_reader :titulo

    has_many :formulariosobservaciones
    has_many :formulariosobsusers

    # inicializa los parametros
    def initialize(dato1, dato2)
      @dato1 = dato1
      @dato2 = dato2
    end

    def descripcion_titulo
      @dato1 + @dato2
    end
  end
end

