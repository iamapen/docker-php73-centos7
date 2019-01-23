FROM centos:centos7
MAINTAINER iamapen

RUN set -x && \
  yum install -y epel-release && \
  rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi && \
  rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
  yum install -y --enablerepo=remi-php73 php php-cli php-bcmath php-gd php-gmp \
    php-json php-mbstring php-mysqlnd php-pdo php-pecl-mysql php-xml php-intl && \
    mod_ssl

RUN yum clean all

EXPOSE 80
EXPOSE 443

