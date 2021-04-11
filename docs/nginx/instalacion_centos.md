## Instalacion Nginx en centos 7

# [Primera opcion de instalacion](https://www.phusionpassenger.com/docs/advanced_guides/install_and_upgrade/nginx/install/oss/el6.html)

## Paso 1: actualice su kernel o desactive SELinux

Lo primero que debe hacer es verificar tres cosas:

¿Qué versión de Passenger se instalará? Puede consultar con curl
-s https://www.phusionpassenger.com/latest_stable_version.json | ruby -rjson -e 'p JSON.parse(STDIN.read)["version"]'.
¿Qué versión de kernel está ejecutando? Puedes averiguarlo corriendo uname -r. ¿SELinux está habilitado? Puedes
averiguarlo corriendo grep SELINUX /etc/selinux/config. Si dice "obligatorio" o "permisivo", entonces SELinux está
habilitado. Si dice "deshabilitado", entonces SELinux está deshabilitado. Si está instalando Passenger 5.1 o posterior,
o si la versión de su kernel ya era al menos 2.6.39, o si SELinux ya estaba deshabilitado, puede pasar al siguiente paso
.

Si SELinux está habilitado, las versiones de Passenger anteriores a 5.1 requieren kernel ≥ 2.6.39. El pasajero 5.1 ha
eliminado este requisito. Si su kernel no es lo suficientemente reciente, hay dos cosas que puede hacer:

Desactive SELinux por completo. Edite /etc/selinux/config, configure SELINUX=disabledy reinicie. Tenga en cuenta que
simplemente configurar SELinux en modo permisivo no es suficiente. -O-

Actualice su kernel a al menos 2.6.39.

## Paso 2: habilita EPEL

### Passenger requires EPEL.

````ngix
sudo yum install -y yum-utils

sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(< /etc/redhat-release tr -dc '0-9.'|cut -d \. -f1).noarch.rpm

sudo yum-config-manager --enable epel

sudo yum clean all && sudo yum update -y
````

Habilite el repositorio opcional ( rhel-6-server-optional-rpms ). Esto se puede hacer habilitando el subcanal opcional
RHEL para RHN-Classic. Para suscripciones basadas en certificados, consulte la Guía de administración de suscripciones
de Red Hat . Los siguientes comandos pueden resultar útiles, pero no se han probado a fondo.

````ngix
sudo subscription-manager register --username $RHN_USERNAME --password $RHN_PASSWORD --auto-attach

sudo subscription-manager repos --enable rhel-6-server-optional-rpms
````

## Paso 3: repare los posibles problemas del sistema

Estos comandos solucionarán problemas comunes que impiden que yum instale Passenger

````ngix
# Ensure curl and nss/openssl are sufficiently up-to-date to talk to the repo
sudo yum update -y

date
# if the output of date is wrong, please follow these instructions to install ntp
sudo yum install -y ntp
sudo chkconfig ntpd on
sudo ntpdate pool.ntp.org
sudo service ntpd start
````

## Paso 4: instale paquetes de pasajeros

Estos comandos instalarán Passenger Nginx a través del repositorio YUM de Phusion. Si ya tenía Nginx instalado, estos
comandos actualizarán Nginx a la versión de Phusion (con Passenger compilado).

````ngix
# Install various prerequisites
sudo yum install -y pygpgme curl

# Add our el6 YUM repository
sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

# Install Passenger Nginx
sudo yum install -y nginx passenger || sudo yum-config-manager --enable cr && sudo yum install -y nginx passenger
````

## Paso 5: habilite el módulo Passenger Nginx y reinicie Nginx

Edite `/etc/nginx/conf.d/passenger.confy` descomente `passenger_root`, `passenger_ruby`
y `passenger_instance_registry_dir`. Por ejemplo, puede ver esto:

````ngix
# passenger_root /some-filename/locations.ini;
# passenger_ruby /usr/bin/ruby;
# passenger_instance_registry_dir /var/run/passenger-instreg;
````

Elimine los caracteres '#', así:

````ngix
passenger_root /some-filename/locations.ini;
passenger_ruby /usr/bin/ruby;
passenger_instance_registry_dir /var/run/passenger-instreg;
````

````ngix
NOTA:

Si no ve una versión comentada de passenger_rooto passenger_instance_registry_dirdentro de pasajero.conf, entonces debe insertarlos usted mismo.

Corre passenger-config --root. Le dirá a la salida alguna ruta. Por ejemplo:

---------------------------
passenger-config --root
/some-filename/locations.ini
---------------------------

Inserte una passenger_rootopción de configuración en /etc/nginx/conf.d/passenger.conf usando el valor que obtuvo. Asegúrese de que passenger_instance_registry_diresté configurado en / var / run / passenger-instreg. Por ejemplo:

---------------------------
passenger_root /some-filename/locations.ini;
passenger_instance_registry_dir /var/run/passenger-instreg;
---------------------------
````

Cuando haya terminado con este paso, reinicie Nginx:

````ngix
sudo service nginx restart
````

## Paso 6: verifique la instalación

Después de la instalación, valide la instalación ejecutando sudo /usr/bin/passenger-config validate-install. Por
ejemplo:

````ngix
sudo /usr/bin/passenger-config validate-install
 * Checking whether this Phusion Passenger install is in PATH... ✓
 * Checking whether there are no other Phusion Passenger installations... ✓
````

Todos los controles deben aprobarse. Si alguna de las comprobaciones no pasa, siga las sugerencias en pantalla.

Finalmente, verifique si Nginx ha iniciado los procesos centrales de Passenger. Corre sudo
/usr/sbin/passenger-memory-stats. Debería ver tanto los procesos de Nginx como los de Passenger. Por ejemplo:

````ngix
sudo /usr/sbin/passenger-memory-stats
Version: 5.0.8
Date   : 2015-05-28 08:46:20 +0200
...

---------- Nginx processes ----------
PID    PPID   VMSize   Private  Name
-------------------------------------
12443  4814   60.8 MB  0.2 MB   nginx: master process /usr/sbin/nginx
12538  12443  64.9 MB  5.0 MB   nginx: worker process
### Processes: 3
### Total private dirty RSS: 5.56 MB

----- Passenger processes ------
PID    VMSize    Private   Name
--------------------------------
12517  83.2 MB   0.6 MB    PassengerAgent watchdog
12520  266.0 MB  3.4 MB    PassengerAgent server
12531  149.5 MB  1.4 MB    PassengerAgent logger
...
````

## Paso 7: actualice regularmente

Las actualizaciones de Nginx, las actualizaciones de pasajeros y las actualizaciones del sistema se entregan a través
del administrador de paquetes de YUM con regularidad. Debe ejecutar el siguiente comando con regularidad para
mantenerlos actualizados:

````ngix
sudo yum update
````

------

# [Segunda opcion de instalacion](https://www.phusionpassenger.com/library/install/apache/install/oss/el7/)

### Paso 1: habilite EPEL

````nginx
sudo yum install -y epel-release yum-utils

sudo yum-config-manager --enable epel

sudo yum clean all && sudo yum update -y
````

Habilite el repositorio opcional ( rhel-7-server-optional-rpms ). Esto se puede hacer habilitando el subcanal opcional
RHEL para RHN-Classic. Para suscripciones basadas en certificados, consulte la Guía de administración de suscripciones
de Red Hat . Los siguientes comandos pueden resultar útiles, pero no se han probado a fondo.

````nginx
sudo subscription-manager register --username $RHN_USERNAME --password $RHN_PASSWORD

POOL=`sudo subscription-manager list --available --all | sed '/^Pool ID:/!d;s/^.*: *//'`

sudo subscription-manager attach --pool="$POOL"

sudo subscription-manager repos --enable rhel-7-server-optional-rpms
````

### Paso 2: repare los posibles problemas del sistema

Estos comandos solucionarán problemas comunes que impiden que yum instale Passenger

````nginx
sudo yum update -y

date
sudo yum install -y ntp

sudo chkconfig ntpd on

sudo ntpdate pool.ntp.org

sudo service ntpd start
````

### Paso 3: instale paquetes de pasajeros

Estos comandos instalarán el módulo Passenger + Apache a través del repositorio YUM de Phusion.

````nginx
sudo yum install -y pygpgme curl

sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

sudo yum install -y mod_passenger || sudo yum-config-manager --enable cr && sudo yum install -y mod_passenger
````

### Paso 4: reinicia Apache

Ahora que el módulo Passenger Apache está instalado, reinicie Apache para asegurarse de que Passenger esté activado:

````nginx
 sudo service nginx restart
````

Paso 5: verifique la instalación

Después de la instalación, valide la instalación ejecutando sudo /usr/bin/passenger-config validate-install. Por ejemplo:

````nginx
 sudo /usr/bin/passenger-config validate-install
 * Checking whether this Phusion Passenger install is in PATH... ✓
 * Checking whether there are no other Phusion Passenger installations... ✓
````

