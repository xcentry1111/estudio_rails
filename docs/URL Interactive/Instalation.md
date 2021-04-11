#### Instalacion de FriendlyId

### En el Gemfile se agrega la gema


```sh
gem 'friendly_id', '~> 5.4.0'
```

#### Correr 

```sh
bundle install
```

#### Agregue una slugcolumna a la tabla deseada (p Users. Ej. )

```sh
rails g migration AddSlugToUsers slug:uniq
```

#### Genere el archivo de configuración amigable y una nueva migración

```sh
rails generate friendly_id
```

#### Nota: Puede eliminar la CreateFriendlyIdSlugsmigración si no usa la función de historial de slug. ( Leer más )

### Ejecute los scripts de migración

```sh
rails db:migrate
```

### Edit the `app/models/user.rb` file as the following:


```sh
class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
end
```

#### Edite el `app/controllers/users_controller.rb` archivo y reemplácelo User.findporUser.friendly.find

```sh
class UserController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
  end
end
```

#### Ahora, cuando crea un nuevo usuario como el siguiente:
```sh
User.create! name: "Joe Schmoe"
```

### A continuación, puede acceder a la página de presentación de usuarios utilizando la URL http: // localhost: 3000 / users / joe-schmoe .

Si está agregando FriendlyId a una aplicación existente y necesita generar slugs para usuarios existentes, hágalo desde la consola, el corredor o agregue una tarea Rake:

```sh
User.find_each(&:save)
```

