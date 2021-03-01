# frozen_string_literal: true

class CreateFormularios < ActiveRecord::Migration[5.1]
  def change
    create_table :formularios do |t|
      t.string :nombre
      t.string :email
      t.text :observacion

      t.timestamps
    end
  end
end
