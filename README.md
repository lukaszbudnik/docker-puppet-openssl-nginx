docker-puppet-openssl-nginx
===========================

Docker image with a puppet manifest used to setup nginx with HTTPS (443) proxy to internal port.

### Base image

This image is based on https://github.com/lukaszbudnik/docker-scala.

### Usage

In order to make the image more generic no default proxy to internal port is pre-configured. 

All users of this image are required to execute the following command (and can freely modify the `FACTER_fqdn` and `FACTER_port` variables or leave them default):

```
FACTER_fqdn=dev FACTER_port=9000 FACTER_random=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c100` puppet apply init.pp
```

NOTE: There is a bug in puppet openssl module and it the above command needs to be invoked twice!

### Exposing non-default HTTPS port

The image exposes port 443 if you need a different HTTPS port please modify the puppet manifest file `init.pp` and remember to expose this new port in `Dockerfile`.
