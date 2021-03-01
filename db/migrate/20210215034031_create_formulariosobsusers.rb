class CreateFormulariosobsusers < ActiveRecord::Migration[5.1]
  def change
    create_table :formulariosobsusers do |t|
      t.references :formulario, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end