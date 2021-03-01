# frozen_string_literal: true

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
require 'test_helper'

class FormularioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
