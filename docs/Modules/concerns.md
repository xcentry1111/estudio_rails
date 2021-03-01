# Funcionamiento de los concern

### Los concerns permiten reutilizar codigo y sirve para el controllers como para los modelos

#### Dentro de la carpeta de models - concenrs se crea un archivo deseado

```sh
  Se crea archivo select_concern.rb
  
  # Estructura del concenrs
  module SelectConcern
      extend ActiveSupport::Concern
    
      def description_title_concent
        titulo
      end
  end
```

### Forma de invocarlo en el modelo que se requiera

```sh
class Formulario < ApplicationRecord
  # Es para que pueda funcionar los concern
  include SelectConcern

  def full_titulo
    <<~HTML
      #{titulo}
    HTML
  end
end

```


## FORMA DE UTILIZARLOS EN EL CONTROLADOR

### Se crea el concern en el controlador con el nombre que desee module_concerns.rb


