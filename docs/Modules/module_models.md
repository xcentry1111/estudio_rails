# Funcionamiento de los module en los modelos

### Creacion de module

#### Se debe de crear una carpeta dentro del modulo con el nombre que desee asociado al modelo que desea implementar

```sh
  -models
    - formulario_producto
    
    Dentro de la carpeta se debe de crear el .rb que se deseea en mi caso se 
    creo un account.rb y adicional a eso se agrega el archivo
    application_record.rb
```

### Ejemplo Account.rb
```sh
module FormularioProducto
  class Account < FormularioProducto::ApplicationRecord
    include SelectConcern
    self.table_name = "formularios"

    attr_reader :titulo

    has_many :formulariosobservaciones
    has_many :formulariosobsusers

    # inicializa los parametros
    def initialize(dato1, dato2)
      @dato1 = dato1
      @dato2 = dato2
    end
    
    def descripcion_titulo
      @dato1 + @dato2
    end
  end
end

```

### Application Record

```sh
module FormularioProducto
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = 'formulario_'
  end
end

```

### Como llamar los metodos que sean requeridos o logica

#### Cuando se envian parametros
```sh
  pp = FormularioProducto::Account.new('Andres Felipe', ' Pelaez').descripcion_titulo
```

#### Cuando se invoca un metodo
```sh
  FormularioProducto::Account.descripcion_titulo
```



