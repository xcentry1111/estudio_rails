# == Schema Information
#
# Table name: formulariosobsusers
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  formulario_id :integer
#  user_id       :integer
#
# Indexes
#
#  index_formulariosobsusers_on_formulario_id  (formulario_id)
#
class Formulariosobsuser < ApplicationRecord
  belongs_to :formulario
end
