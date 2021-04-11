## Instalacion de cache en Rails

### [RAILS 5](https://blog.appsignal.com/2018/03/20/fragment-caching-in-rails.html)

Probando el almacenamiento en caché localmente El almacenamiento en caché está desactivado en el desarrollo de forma
predeterminada, para asegurarse de que siempre obtenga respuestas nuevas de su aplicación. Para probar el almacenamiento
en caché localmente, deberá activarlo en su configuración de desarrollo.

En Rails 5, puede activar temporalmente el almacenamiento en caché desde la línea de comandos. Esto usará el almacén de
memoria, lo que significa que los fragmentos almacenados en caché se mantendrán en la memoria en el proceso Ruby del
servidor web.

````sh
rails dev: cache

El modo de desarrollo ahora se está almacenando en caché.
````

Puede ejecutar el mismo comando para desactivar el almacenamiento en caché.

### Almacenamiento en caché de fragmentos

Digamos que tenemos una página que muestra todos los productos de una tienda en una sola página. Para hacer eso, tenemos
una vista de índice que muestra los productos.

````html
# app/views/products/index.html.erb
<table>
    <thead>
    <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Image url</th>
        <th>Price</th>
        <th colspan="3"></th>
    </tr>
    </thead>

    <tbody>
    <% @products.each do |product| %>
    <%= render product %>
    <% end %>
    </tbody>
</table>
````

For each product, the `_product.html.erb` partial is rendered, which takes care of displaying a table row with the
product’s details.

````html
# app/views/products/_product.html.erb
<tr>
    <td><%= product.title %></td>
    <td><%= product.description %></td>
    <td><%= product.image_url %></td>
    <td><%= product.price %></td>
    <td><%= link_to 'Show', product %></td>
    <td><%= link_to 'Edit', edit_product_path(product) %></td>
    <td><%= link_to 'Destroy', product, method: :delete, data: { confirm: 'Are you sure?' } %></td>
</tr>
````

Para ahorrar tiempo renderizando todos estos parciales, podemos usar el almacenamiento en caché de fragmentos integrado
de Rails , que almacena parte de la vista renderizada como un fragmento. Para solicitudes posteriores, se utiliza el
fragmento guardado previamente en lugar de volver a renderizarlo.

Para almacenar en `caché` un fragmento, envuélvalo en un bloque con el cacheayudante.

````html

<table>
    # ...
    <tbody>
    <% @products.each do |product| %>
    <% cache(product) do %>
    <%= render product %>
    <% end %>
    <% end %>
    </tbody>
</table>
````

-----

# [Almacenamiento en caché básico](https://devcenter.heroku.com/articles/caching-strategies#low-level-caching)

Para comenzar, asegúrese de que config.action_controller.perform_caching esté configurado como verdadero para su
entorno. Esta bandera normalmente se establece en el config / environment / *. Rb correspondiente. De forma
predeterminada, el almacenamiento en caché está deshabilitado para desarrollo y prueba, y habilitado para producción.

````ruby
config.action_controller.perform_caching = true
````

## Almacenamiento en caché de páginas

````ruby

class ProductsController < ActionController

  caches_page :index

  def index; end

end
````

## Almacenamiento en caché de fragmentos

````html
<% Order.find_recent.each do |o| %>
<%= o.buyer.name %> bought <% o.product.name %>
<% end %>

<% cache do %>
All available products:
<% Product.find(:all).each do |p| %>
<%= link_to p.name, product_url(p) %>
<% end %>
<% end %>
````

El bloque de caché en nuestro ejemplo se vinculará a la acción que lo llamó y se escribirá en el mismo lugar que el
caché de acciones, lo que significa que si desea almacenar en caché varios fragmentos por acción, debe proporcionar un
action_suffix a la llamada de caché:

````html
<% cache(:action => 'recent', :action_suffix => 'all_prods') do %>
All available products:

----------------------------------------

<% cache(product) do %>
<div><%= link_to product, product.name %>: <%= product.price%></div>
<div><%= do_something_comlicated%></div>
<% end %>

----------------------------------------

# index.html.erb
<% cache("top_products", :expires_in => 1.hour) do %>
<div id="topSellingProducts">
    <% @recent_product = Product.order("units_sold DESC").limit(20) %>
    <%= render :partial => "product", :collection => @recent_products %>
</div>
<% end %>
````

## Almacenamiento en caché de SQL

El almacenamiento en caché de consultas es una función de Rails que almacena en caché el conjunto de resultados devuelto
por cada consulta. Si Rails vuelve a encontrar la misma consulta durante la solicitud actual, utilizará el conjunto de
resultados en caché en lugar de ejecutar la consulta en la base de datos.

````ruby

class ProductsController < ActionController

  before_filter :authenticate, :only => [:edit, :create]
  caches_page :list
  caches_action :edit
  cache_sweeper :store_sweeper, :only => [:create]

  def list
    # Run a find query
    Product.find(:all)
  end

  def create
    expire_page :action => :list
    expire_action :action => :edit
  end

  def edit; end

end
````

## Almacenamiento en caché de bajo nivel

El almacenamiento en caché de bajo nivel implica el uso del Rails.cacheobjeto directamente para almacenar en caché
cualquier información. Úselo para almacenar cualquier dato que sea costoso de recuperar y que pueda permitirse el lujo
de estar algo desactualizado. Las consultas a la base de datos o las llamadas a la API son usos comunes para esto.

La forma más eficaz de implementar el almacenamiento en caché de bajo nivel es utilizar el Rails.cache.fetchmétodo.
Leerá un valor de la caché si está disponible; de lo contrario, ejecutará un bloque que se le haya pasado y devolverá el
resultado:

````shell
>> Rails.cache.fetch('answer')
==> "nil"
>> Rails.cache.fetch('answer') {1 + 1}
==> 2
Rails.cache.fetch('answer')
==> 2
````
