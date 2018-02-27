FROM ubuntu
MAINTAINER      yakeworld "yakeworld@gmail.com"

# Make sure we don't get notifications we can't answer during building.
ENV     DEBIAN_FRONTEND noninteractive

# Update the system

RUN apt-get -q update \
&&  apt-get install -yq apt-utils locales \
&&  apt-get -yq install apache2 build-essential libcrypt-ssleay-perl libnet-ssleay-perl libcompress-raw-lzma-perl libio-compress-lzma-perl wget libyaml-perl libconfig-yaml-perl fcgiwrap spawn-fcgi libfcgi-perl  libfcgi-procmanager-perl perl-modules libnet-ssleay-perl libcrypt-ssleay-perl liburi-perl libjson-perl libjavascript-minifier-xs-perl libperlio-gzip-perl libmodule-install-perl libmodule-build-perl liblocal-lib-perl libjson-pp-perl libcpan-meta-perl libdbd-sqlite3 libdbd-sqlite3-perl libcurl4-nss-dev get-flash-videos vim mariadb-server mariadb-client libdbd-mysql-perl \
&&  locale-gen en_US en_US.UTF-8 \
&&  chown -R www-data:www-data /var/www/html \
&&  cd /var/www/html && wget http://www.jmarshall.com/tools/cgiproxy/releases/cgiproxy.latest.tar.gz && tar zxf cgiproxy.latest.tar.gz \
&&  chmod +x nph-proxy.cgi ; ./nph-proxy.cgi install-modules ; ./nph-proxy.cgi install \
&&  apt-get clean ; rm -rf /tmp/* /var/tmp/* ; rm -rf /var/lib/apt/lists/* ; rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup ; rm /opt/cgiproxy/cgiproxy.latest.tar.gz ;
WORKDIR /var/www/html
CMD     ["/bin/bash", "-c", "sudo -u www-data ./nph-proxy.cgi start-fcgi"]