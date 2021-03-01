# frozen_string_literal: true

# == Schema Information
#
# Table name: paginas
#
#  id         :integer          not null, primary key
#  estado     :integer          default("pending")
#  titulo     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Pagina < ApplicationRecord
  include SelectConcern

  enum estado: [:pending, :active]

  def traslate
    if self.estado == :pending
      'Pendiente'
    else
      'Activo'
    end
  end


end
