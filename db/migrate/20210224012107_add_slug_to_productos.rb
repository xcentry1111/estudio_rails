class AddSlugToProductos < ActiveRecord::Migration[5.1]
  def change
    add_column :productos, :slug, :string
    add_index :productos, :slug, unique: true
  end
end
