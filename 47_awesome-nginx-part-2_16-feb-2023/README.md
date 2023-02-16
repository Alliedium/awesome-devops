# Awesome NGINX, PART 2 

This lesson provides a set of instructions to run HTTP backend servers with Virtual Hosting, Terminate TLS, and no HTTP routing using Nginx. The instructions are given in the form of a script that the user needs to run, which generates two self-signed certificates and configures Nginx to make it extract the server_name from the certificates and compare it with the client certification.

The instructions involve several commands, such as running HTTP backend servers, generating self-signed certificates, studying new Nginx configuration, and applying the new configuration. Moreover, it describes how to check that the reverse proxy works as expected and how to fix permission for Nginx private keys.

The lesson has covered a few key subjects including Nginx, Virtual Hosting, TLS, HTTP routing, backend servers, self-signed certificates, server_name, ssl_preread_server_name, map block, stream block, reverse proxy, private keys, root permissions, child process, and http user.

This lesson covers examples 5-6 from
https://github.com/alliedium/awesome-nginx.git

