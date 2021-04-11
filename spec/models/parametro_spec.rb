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
require 'rails_helper'

RSpec.describe Parametro, type: :model do

  before(:all) do
    @parametro = Parametro.new(descripcion: "Ingresa el dato")
  end

  # se crea variable
  let(:prueba) {@parametro.descripcion}

  it "Valida el dato que se creo el parametro" do
    expect(@parametro.descripcion).to eq(prueba)
  end

  describe 'Validacion unica' do
    it { should validate_uniqueness_of(:descripcion)}
  end

end
