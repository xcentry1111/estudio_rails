## [Instalacion de Samba](https://linuxize.com/post/how-to-install-and-configure-samba-on-centos-7/)

###Instalación de Samba en CentOS
Samba está disponible en los repositorios estándar de CentOS. Para instalarlo en su sistema CentOS, ejecute el siguiente comando:

```sh
sudo yum install samba samba-client
```

Una vez completada la instalación, inicie los servicios de Samba y habilítelos para que se inicien automáticamente al arrancar el sistema:

```sh
sudo systemctl start smb.service
sudo systemctl start nmb.service

sudo systemctl enable smb.service
sudo systemctl enable nmb.service
```

El smbdservicio proporciona servicios de impresión y uso compartido de archivos y escucha en los puertos TCP 139 y 445. El nmbdservicio proporciona servicios de nombres NetBIOS sobre IP a los clientes y escucha en el puerto UDP 137.

### Configurar el cortafuegos 

Ahora que Samba está instalado y ejecutándose en su máquina CentOS, deberá configurar su firewall y abrir los puertos necesarios. Para hacerlo, ejecute los siguientes comandos:

```sh
firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --zone=public --add-service=samba
```

### Creación de usuarios de Samba y estructura de directorios

Para facilitar el mantenimiento y la flexibilidad en lugar de utilizar los directorios de inicio estándar ( /home/user), todos los directorios y datos de Samba se ubicarán en el /sambadirectorio.

Empiece por crear el /sambadirectorio:

```sh
sudo mkdir /samba
```

Crea un nuevo grupo llamado sambashare. Luego agregaremos todos los usuarios de Samba a este grupo.

```sh
sudo groupadd sambashare 
```

Establezca la propiedad del grupo de/samba directorio en :sambashare

```sh
sudo chgrp sambashare /samba
```

Samba usa usuarios de Linux y un sistema de permisos de grupo, pero tiene su propio mecanismo de autenticación separado de la autenticación estándar de Linux. Crearemos los usuarios usando la useraddherramienta estándar de Linux y luego configuraremos la contraseña de usuario con la `smbpasswd` utilidad.

Como mencionamos en la introducción, crearemos un usuario regular que tendrá acceso a su recurso compartido de archivos privados y una cuenta administrativa con acceso de lectura y escritura a todos los recursos compartidos en el servidor Samba.

### Creación de usuarios de Samba

Para crear un nuevo usuario llamado `josh`, use el siguiente comando:

```sh
sudo useradd -M -d /samba/josh -s /usr/sbin/nologin -G sambashare josh
```

Las `useradd` opciones tienen los siguientes significados:

-M-no cree el directorio de inicio del usuario. Crearemos manualmente este directorio.

-d /samba/josh: establece el directorio de inicio del usuario en /samba/josh.

-s /usr/sbin/nologin - deshabilitar el acceso al shell para este usuario.

-G sambashare- agregar el usuario al sambasharegrupo.

Cree el directorio de inicio del usuario y establezca la propiedad del directorio en usuario `josh` y grupo `sambashare`:

```sh
sudo mkdir /samba/josh
sudo chown josh:sambashare /samba/josh
```

El siguiente comando agregará el bit setgid al `/samba/josh` directorio para que los archivos recién creados en este directorio hereden el grupo del directorio principal. De esta manera, no importa qué usuario cree un nuevo archivo, el archivo tendrá el grupo-propietario de sambashare. Por ejemplo, si no establece los permisos del directorio en 2770 y el sadminusuario crea un nuevo archivo, el usuario joshno podrá leer / escribir en este archivo.

```sh
sudo chmod 2770 /samba/josh
```

Agregue la `josh` cuenta de usuario a la base de datos de Samba estableciendo la contraseña de usuario:

```sh
sudo smbpasswd -a josh
```

Se le pedirá que ingrese y confirme la contraseña de usuario.

```sh
New SMB password:
Retype new SMB password:
Added user josh.
```

Una vez establecida la contraseña, habilite la cuenta de Samba escribiendo:

```sh
sudo smbpasswd -e josh

Enabled user josh.
```

Para crear otro usuario, repita el mismo proceso que al crear el usuario josh.

A continuación, creemos un usuario y un grupo sadmin. Todos los miembros de este grupo tendrán permisos administrativos. Más adelante, si desea otorgar permisos administrativos a otro usuario, simplemente agregue ese usuario al sadmingrupo .

Cree el usuario administrativo escribiendo:

```sh
sudo useradd -M -d /samba/users -s /usr/sbin/nologin -G sambashare sadmin
```

El comando anterior también creará un grupo `sadmin` y añadir el usuario a la vez `sadmin` y `sambashare` grupos.

Establezca una contraseña y habilite al usuario:

```sh
sudo smbpasswd -a sadmin
sudo smbpasswd -e sadmin
```

A continuación, cree el `Users` directorio compartido:

```sh
sudo mkdir /samba/users
```

Establezca la propiedad del directorio en usuario `sadmin` y grupo `sambashare`:

```sh
sudo chown sadmin:sambashare /samba/users
```

Este directorio será accesible para todos los usuarios autenticados. El siguiente comando configura el acceso de escritura / lectura a los miembros del `sambashare` grupo en el `/samba/users` directorio:

```sh
sudo chmod 2770 /samba/users
```

### Configuración de recursos compartidos de Samba

Abra el archivo de configuración de Samba y agregue las secciones:

```sh
sudo nano /etc/samba/smb.conf
```

```sh
/etc/samba/smb.conf
[users]
    path = /samba/users
    browseable = yes
    read only = no
    force create mode = 0660
    force directory mode = 2770
    valid users = @sambashare @sadmin

[josh]
    path = /samba/josh
    browseable = no
    read only = no
    force create mode = 0660
    force directory mode = 2770
    valid users = josh @sadmin
```

Las opciones tienen los siguientes significados:

[users]y [josh]- Los nombres de los recursos compartidos que utilizará al iniciar sesión.

path - El camino a la acción.

browseable- Si el recurso compartido debe incluirse en la lista de recursos compartidos disponibles. Si configura a nootros usuarios, no podrán ver el recurso compartido.

read only- Si los usuarios especificados en la valid userslista pueden escribir en este recurso compartido.

force create mode - Establece los permisos para los archivos recién creados en este recurso compartido.

force directory mode - Establece los permisos para los directorios recién creados en este recurso compartido.

valid users- Una lista de usuarios y grupos que pueden acceder al recurso compartido. Los grupos tienen el prefijo del @símbolo.

Para obtener más información sobre las opciones disponibles, consulte la página de documentación del archivo de configuración de Samba .

Una vez hecho esto, reinicie los servicios de Samba con:

```sh
sudo systemctl restart smb.service
sudo systemctl restart nmb.service
```

### Conexión a un recurso compartido de Samba desde Linux

Para instalar smbclienten Ubuntu y Debian, ejecute:

```sh
sudo apt install smbclient
```

Para instalar smbclienten CentOS y Fedora, ejecute:

```sh
sudo yum install samba-client
```

La sintaxis para acceder a un recurso compartido de Samba es la siguiente:

```sh
mbclient //samba_hostname_or_server_ip/share_name -U username
```

Por ejemplo, para conectarse a un recurso compartido nombrado josh en un servidor Samba con una dirección IP 192.168.121.118como usuario josh, debe ejecutar:

```sh
smbclient //192.168.121.118/josh -U josh
```

Se le pedirá que ingrese la contraseña de usuario.

```sh
Enter WORKGROUP\josh's password:
```

Una vez que ingrese la contraseña, se iniciará sesión en la interfaz de línea de comandos de Samba.

```sh
Try "help" to get a list of possible commands.
smb: \>
```

### Montaje de la acción de Samba

Para montar un recurso compartido de Samba en Linux, primero debe instalar el cifs-utilspaquete.

En Ubuntu y Debian ejecute:

```sh
sudo apt install cifs-utils
```

En CentOS y Fedora ejecute:

```sh
sudo yum install cifs-utils
```

A continuación, cree un punto de montaje:

```sh
sudo mkdir /mnt/smbmount
```

Monte el recurso compartido con el siguiente comando:

```sh
sudo mount -t cifs -o username=username //samba_hostname_or_server_ip/sharename /mnt/smbmount
```

Por ejemplo, para montar un recurso compartido nombrado joshen un servidor Samba con una dirección IP 192.168.121.118 como usuario joshen el /mnt/smbmountpunto de montaje, ejecutaría:

```sh
sudo mount -t cifs -o username=josh //192.168.121.118/josh /mnt/smbmount
```

Se le pedirá que ingrese la contraseña de usuario.

```sh
Password for josh@//192.168.121.118/josh:  ********
```






