# == Schema Information
#
# Table name: formulariosobservaciones
#
#  id            :integer          not null, primary key
#  observation   :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  formulario_id :integer
#
# Indexes
#
#  index_formulariosobservaciones_on_formulario_id  (formulario_id)
#
class Formulariosobservacion < ApplicationRecord
  belongs_to :formulario
end
