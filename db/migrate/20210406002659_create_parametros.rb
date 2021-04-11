class CreateParametros < ActiveRecord::Migration[5.1]
  def change
    create_table :parametros do |t|
      t.string :descripcion
      t.string :observacion

      t.timestamps
    end
  end
end
