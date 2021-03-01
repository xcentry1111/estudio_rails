class CreateFormulariosobservaciones < ActiveRecord::Migration[5.1]
  def change
    create_table :formulariosobservaciones do |t|
      t.references :formulario, foreign_key: true
      t.string :title
      t.string :observation

      t.timestamps
    end
  end
end
