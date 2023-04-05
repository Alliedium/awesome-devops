# Awesome NGINX, PART 2 

This lesson provides a set of instructions to run HTTP backend servers with Virtual Hosting, Terminate TLS, and no HTTP routing using Nginx. The instructions are given in the form of a script that the user needs to run, which generates two self-signed certificates and configures Nginx to make it extract the server_name from the certificates and compare it with the client certification.

The instructions involve several commands, such as running HTTP backend servers, generating self-signed certificates, studying new Nginx configuration, and applying the new configuration. Moreover, it describes how to check that the reverse proxy works as expected and how to fix permission for Nginx private keys.

The lesson has covered a few key subjects including Nginx, Virtual Hosting, TLS, HTTP routing, backend servers, self-signed certificates, server_name, ssl_preread_server_name, map block, stream block, reverse proxy, private keys, root permissions, child process, and http user.

- NGINX
- ssl_preread
- tls-termination
- Stream, map
- File access in Linux
- Issue a self-signed SSL certificate
- nginx.service
- nginx -t, nginx -T
- w3m, lsof 

This lesson covers examples 5-6 from
https://github.com/alliedium/awesome-nginx.git


## Prerequisites: ##

- Create VM for running commands and scripts. We used `Manjaro` Linux distribution. You can use [Alliedium/awesome-linux-config](https://github.com/Alliedium/awesome-proxmox/tree/main/vm-cloud-init-shell) scripts to create VM in `Proxmox`. 
- Install docker, follow [Docker installed](../05_docker_basic_commands_postgres_23-aug-2022#prerequisites) step from `Prerequisites` section.
- Install `lsof` tool. `lsof` command stands for List Of Open File. This [command](https://www.geeksforgeeks.org/lsof-command-in-linux-with-examples/) provides a list of files that are opened. Basically, it gives the information to find out the files which are opened by which process
  
  ```
  sudo pacman -S lsof
  ```  

- Follow [Prerequisites](https://github.com/Alliedium/awesome-nginx#prerequisites) steps from `awesome-nginx` repo

# References
## Docker
- https://docs.docker.com/engine/tutorials/networkingcontainers/
- https://github.com/samos123/docker-veth/blob/master/docker-veth.sh

## Nginx

- http://nginx.org/en/docs/
- http://nginx.org/en/docs/beginners_guide.html
- https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/ 
- https://docs.nginx.com/nginx/admin-guide/load-balancer/tcp-udp-load-balancer/
- https://www.baeldung.com/linux/nginx-docker-container
- https://github.com/digitalocean/nginxconfig.io
- https://www.digitalocean.com/community/tools/nginx
- https://github.com/trimstray/nginx-admins-handbook
- https://github.com/h5bp/server-configs-nginx
- https://artifacthub.io/packages/helm/bitnami/nginx
- https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-hello
- https://hub.docker.com/r/nginxdemos/hello/
- https://www.youtube.com/watch?v=7VAI73roXaY
- https://levelup.gitconnected.com/multiplex-tls-traffic-with-sni-routing-ece1e4e43e56

