module ModuleConcerns
  extend ActiveSupport::Concern

  def prueba(dato)
    Formulario.first.update titulo: dato
  end




end
