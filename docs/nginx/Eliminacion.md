# Eliminacion de nginx en centos 7

```sh
[ramans@localhost ~]$ sudo systemctl stop nginx.service
[ramans@localhost ~]$ sudo systemctl disable nginx.service
[ramans@localhost ~]$ sudo rm -rf /etc/nginx
[ramans@localhost ~]$ sudo rm -rf /var/log/nginx
[ramans@localhost ~]$ sudo rm -rf /var/cache/nginx/ 
[ramans@localhost ~]$ sudo rm -rf /usr/lib/systemd/system/nginx.service
```

## Uninstall Nginx

```sh
[ramans@localhost ~] sudo yum remove nginx
```
