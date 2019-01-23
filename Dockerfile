FROM centos:centos7
MAINTAINER iamapen

RUN set -x \
  && yum install -y epel-release \
  && rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi \
  && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
  && yum install -y --enablerepo=remi-php73 php php-cli php-bcmath php-gd php-gmp \
       php-json php-mbstring php-mysqlnd php-pdo php-pecl-mysql php-xml php-intl \
       mod_ssl

RUN yum clean all

# 自己証明書を発行
RUN set -x \
  && cd /tmp \
  && openssl genrsa 2048 > server.key \
  && openssl req -new -key server.key -subj "/C=JP/ST=Tokyo/L=Chuo-ku/O=RMP Inc./OU=web/CN=localhost" > server.csr \
  && openssl x509 -in server.csr -days 3650 -req -signkey server.key > server.crt \
  && cp server.crt /etc/httpd/conf.d/server.crt \
  && cp server.key /etc/httpd/conf.d/server.key \
  && chmod 755 -R /var/www/html \
  && chmod 400 /etc/httpd/conf.d/server.key


EXPOSE 80
EXPOSE 443

CMD ["httpd", "-D", "FOREGROUND"]

