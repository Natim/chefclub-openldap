#!/bin/bash

if [ ! -z "${1}" ]; then
    exec ${@}
fi

# Unimplemented at this point, can be used to initialize the
# docker container on run
SUFFIX=${OPENLDAP_SUFFIX:-dc=chefclub,dc=tv}
ROOTDN=${OPENLDAP_ROOTDN:-cn=root,${SUFFIX}}
ROOTCN=$(echo ${ROOTDN} | awk -F '[,=]' '{print $2}')
ROOTPW=${OPENLDAP_ROOT_PASSWORD:-Secret1234}
DATADIR=${OPENLDAP_DATADIR:-/var/lib/ldap}
DC=$(echo ${SUFFIX} | awk -F '[,=]' '{print $2}')
ENC_ROOTPW=$(slappasswd -s ${ROOTPW})
TLS_CERT_FILE=${OPENLDAP_TLS_CERTFILE:-/etc/pki/tls/certs/star_chefclub_tv.pem}
TLS_KEY_FILE=${OPENLDAP_TLS_KEYFILE:-/etc/pki/tls/private/star_chefclub_tv.key}

[[ -x /usr/local/sbin/dir-init.sh ]] && /usr/local/sbin/dir-init.sh && chmod 444 /usr/local/sbin/dir-init.sh

echo "Running OpenLDAP slapd..."
exec /usr/sbin/slapd -d 3 -u ldap -g ldap -h "ldap:/// ldapi:///"
