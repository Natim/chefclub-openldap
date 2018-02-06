FROM centos:latest

LABEL maintainer="Greg Wojtak <greg.wojtak@gmail.com>"

RUN yum -y update && \
    yum -y install \
        openldap-servers \
        openldap-clients && \
    yum clean all && \
    rm -rf /var/cache/yum /var/log/anaconda/*.log

COPY overlay/ /

EXPOSE 389

ENTRYPOINT ["/entrypoint.sh"]

