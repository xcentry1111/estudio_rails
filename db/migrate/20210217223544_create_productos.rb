class CreateProductos < ActiveRecord::Migration[5.1]
  def change
    create_table :productos do |t|
      t.string :titulo
      t.string :descripcion

      t.timestamps
    end
  end
end
