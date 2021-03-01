class AddEstadoToPaginas < ActiveRecord::Migration[5.1]
  def change
    add_column :paginas, :estado, :integer, default: 0
  end
end
