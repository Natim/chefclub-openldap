# OpenLDAP-in-a-Box

## Installation

To use this image, make certain you have your TLS certificate and key available.  In this example,
both files are in the home directory.

```shell
git clone https://github.com/gwojtak/chefclub-openldap
cd chefclub-openldap
cp ~/star_chefclub_tv.pem overlay/etc/pki/tls/certs/
cp ~/star_chefclub_tv.key overlay/etc/pki/tls/private/
chmod 400 overlay/etc/pki/tls/private/star_chefclub_tv.key
docker build -t myrepo/openldap .
docker run -itd -v /path/to/persistent/data/dir:/var/lib/ldap --name openldap_server -p 389:389 myrepo/openldap
```

This will build the docker image and tag it as ```myrepo/openldap:latest```.  You may use whatever tags
you wish.  The container is then started with the specified mapped volume and listening on port 389.

*Note:* If you do not specify a volume mapping, data will persist across stopping and starting of
the container *BUT* not if the container is removed.  Use a volume mapping in order to persist data
if you suspect you may have to destroy the container, or migrate servers at any point.

## Working with LDAP

LDAP has some command line tools, however they are not the most user-friendly. It is usually
desirable to use a UI like [Apache Directory Studio](http://directory.apache.org/studio/) or
[phpLDAPAdmin](http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page).

You may also use a phpLDAPAdmin docker container.  ```osixia/phpldapadmin``` has been used with
success, but will require a bit of work to modify the user template that the app uses.
