### [Instalacion de gzip en nginx](https://www.techrepublic.com/article/how-to-configure-gzip-compression-with-nginx/)

#### The configuration

Te sorprenderá lo sencillo que es esto. Abra el archivo /etc/nginx/nginx.conf. Lo primero que debe hacer es buscar la directiva:

````nginx
gzip on;
````

Comenta eso así:

````nginx
#gzip on;
````

Ahora agregue el siguiente contenido encima de la línea que acaba de comentar:

````nginx
gzip on;
gzip_vary on;
gzip_min_length 10240;
gzip_proxied expired no-cache no-store private auth;
gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml;
gzip_disable "MSIE [1-6]\.";
````

Aquí hay una explicación de la configuración, línea por línea:

````nginx
- gzip on; - habilita la compresión gzip
- gzip_vary on: - le dice a los proxies que almacenen en caché tanto las versiones gzip como las regulares de un recurso
- gzip_min_length 1024; - informa a NGINX que no comprima nada más pequeño que el tamaño definido
- gzip_proxied: comprime los datos incluso para los clientes que se conectan a través de proxies (aquí habilitamos la compresión si: un encabezado de respuesta incluye "caducado", "sin caché", "sin almacenamiento", "privado" y "autorización" parámetros)
- gzip_types: habilita los tipos de archivos que se pueden comprimir
- gzip_disable "MSIE [1-6] \."; - deshabilitar la compresión para las versiones 1-6 de Internet Explorer
````



