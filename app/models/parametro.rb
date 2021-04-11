# == Schema Information
#
# Table name: parametros
#
#  id          :integer          not null, primary key
#  descripcion :string
#  observacion :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Parametro < ApplicationRecord

  validates_uniqueness_of :descripcion

  def multiparametro(*p)
    "#{p[0].to_s} - #{p[1].to_s} - #{p[1].to_s}"
  end
end
