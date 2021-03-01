# frozen_string_literal: true

module FormulariosUser
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'formulario_'
  end
end
