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
class Formulario < ApplicationRecord
  include SelectConcern

  has_many :formulariosobservaciones
  has_many :formulariosobsusers

  validates_presence_of :titulo

  def full_titulo
    <<~HTML
      #{titulo}
    HTML
  end
end
