# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  #   inflect.plural /^(ox)$/i, '\1en'
  #   inflect.singular /^(ox)en/i, '\1'
  inflect.irregular 'formulario', 'formularios'
  inflect.irregular 'formulariosobservacion', 'formulariosobservaciones'
  inflect.irregular 'formulariosobsuser', 'formulariosobsusers'
  inflect.irregular 'pagina', 'paginas'
  inflect.irregular 'producto', 'productos'
  inflect.irregular 'book', 'books'
  inflect.irregular 'parametro', 'parametros'
  #   inflect.uncountable %w( fish sheep )
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
