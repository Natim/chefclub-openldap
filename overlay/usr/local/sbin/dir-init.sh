#!/bin/bash
#


[[ -f /var/lib/ldap/DB_CONFIG ]] || cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chmod 600 /var/lib/ldap/DB_CONFIG
chown ldap:ldap /var/lib/ldap/DB_CONFIG

slapd -u ldap -g ldap -h ldapi:///
_pid=$(ps -ef|grep slapd|grep -v grep|awk '{print $2}')
sleep 3

ldapmodify -Y EXTERNAL -H ldapi:/// -f /ldif/config-init.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
ldapadd -x -h localhost -D cn=root,dc=chefclub,dc=tv -w Secret1234 -f /ldif/chefclub.ldif

kill ${_pid}
