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
FactoryBot.define do
  factory :parametro do
    descripcion { "MyString" }
    observacion { "MyText" }
  end
end
