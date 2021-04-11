## [Instalacion de postgres en centos 7](https://yallalabs.com/linux/how-to-install-postgresql-10-on-centos-7-rhel-7/)

### Paso 1: agregar el repositorio de PostgreSQL 10

```postgresql
# yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm -y
```
### Paso 2: Instale PostgreSQL 10

```postgresql
# yum install postgresql10 postgresql10-server postgresql10-contrib postgresql10-libs -y
```

### Paso 3: Inicie PostgreSQL

– Initialize PostgreSQL:

```postgresql
# /usr/pgsql-10/bin/postgresql-10-setup initdb
Initializing database ... OK
```

– Start/Enable PostgreSQL:

```postgresql
# systemctl enable postgresql-10.service
# systemctl start postgresql-10.service
```

### Paso 4: Acceder a la base de datos

- Cambie al usuario de postgres:

```postgresql
# su – postgres o sudo -u postgres -i o sudo -u postgres psql
```

- Conéctese al terminal PostgreSQL:

```postgresql
# psql
```

- Cambio de contraseña de postgres

```postgresql
\password postgres
```

### Paso 5: Ejemplos de uso

- Lista de todas las bases de datos:

```postgresql
# \list
```

- Conectarse a una base de datos:

```postgresql
# \c database_name
```

- Lista de todas las tablas

```postgresql
# \d
```

- Crear una base de datos

```postgresql
# createdb database_name
# createdb database_name OWNER rolename;
```

- Crea una tabla

```postgresql
# create table employees (name varchar(25), surname varchar(25));

```

- Insertar registros

```postgresql
# INSERT INTO employees VALUES ('Lotfi','waderni');
```

- Salir del indicador de PosgreSQL:

```postgresql
# \q
```

## Conexión remota a PostgreSQL en Centos 7

Primero editamos el archivo postgresql.conf

```postgresql
sudo vim /var/lib/pgsql/data/postgresql.conf
```

Descomentamos la linea listen_addresses = "localhost" y agregamos el asterisco *.

```postgresql
listen_addresses = "*"
```

Luego editamos el archivo pg_hba.conf

```postgresql
sudo vim /var/lib/pgsql/data/pg_hba.conf
```

Habilitamos para que se acceda desde la red 192.168.1.1/24 agregando al final la siguiente linea:

```postgresql
host    all             all             0.0.0.0/0             md5
```

Reiniciamos el servicio de PostgreSQL.

```postgresql
sudo systemctl restart postgresql
```

Habilitacion de puerto 5432

```postgresql
firewall-cmd --zone=public --add-port=5432/tcp --permanent

firewall-cmd --reload
```
