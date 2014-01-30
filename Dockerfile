# puppet + nginx + openssl derived from lukasz/docker-scala
#
# Version     0.3

FROM lukasz/docker-scala
MAINTAINER Łukasz Budnik lukasz.budnik@gmail.com

ADD init.pp /root/init.pp
WORKDIR /root

RUN wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
RUN dpkg -i puppetlabs-release-precise.deb
RUN rm puppetlabs-release-precise.deb
RUN apt-get update

RUN apt-get install -y puppet-common=2.7.22-1puppetlabs1
RUN apt-get install -y puppet=2.7.22-1puppetlabs1
RUN puppet module install jfryman/nginx
RUN puppet module install --ignore-dependencies camptocamp/openssl

RUN echo "Since version 0.3 running puppet is commented out"
RUN echo "This is in order to make the image more generic one with no default internal port 9000 nginx configuration."
RUN echo "However, nginx will still have port 443 open to the external world (this can be changed by editing puppet manifest file)."
RUN echo "All users of this image are required to execute the following commands (and can freely modify the FACTER_* variables used below):"
RUN echo "There is a bug in puppet openssl module and it needs to be invoked twice!"
RUN echo "FACTER_fqdn=dev FACTER_port=9000 FACTER_random=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c100` puppet apply init.pp"

EXPOSE 443
