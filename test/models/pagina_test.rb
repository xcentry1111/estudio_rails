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
require 'test_helper'

class PaginaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
