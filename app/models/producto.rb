# == Schema Information
#
# Table name: productos
#
#  id          :integer          not null, primary key
#  descripcion :string
#  slug        :string
#  titulo      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_productos_on_slug  (slug) UNIQUE
#
class Producto < ApplicationRecord
  extend FriendlyId
  friendly_id :titulo, use: :slugged

  validates_presence_of :titulo

  include SelectConcern

end
