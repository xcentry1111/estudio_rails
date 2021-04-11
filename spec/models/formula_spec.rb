require 'rails_helper'

RSpec.describe Formulario, type: :model do

  # Asociaciones shoulda-matchers
  describe 'associations' do
    it 'contains has_many associations' do
      is_expected.to have_many(:formulariosobservaciones)
      is_expected.to have_many(:formulariosobsusers)
    end
  end

  # Valida los campos con shoulda-matchers
  describe 'validations' do
    it { should validate_presence_of(:titulo) }
  end
end
