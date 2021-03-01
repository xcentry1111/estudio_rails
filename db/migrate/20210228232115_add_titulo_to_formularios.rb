class AddTituloToFormularios < ActiveRecord::Migration[5.1]
  def change
    add_column :formularios, :titulo, :string
  end
end
