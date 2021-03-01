# frozen_string_literal: true

# Migracion  crear paginas
class CreatePaginas < ActiveRecord::Migration[5.1]
  def change
    create_table :paginas do |t|
      t.string :titulo

      t.timestamps
    end
  end
end
