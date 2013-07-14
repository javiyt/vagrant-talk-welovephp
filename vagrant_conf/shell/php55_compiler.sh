#!/bin/sh
SRC_DIR=$2
VERSION_DIR="$SRC_DIR/$1"

#`sudo apt-get build-dep php5`
if [ ! -d "$SRC_DIR" ]; then
	`sudo mkdir $SRC_DIR`
fi

if [ -d "$VERSION_DIR" ]; then
	`sudo rm -Rf $VERSION_DIR`
fi
`sudo mkdir $VERSION_DIR && sudo chown vagrant:vagrant $VERSION_DIR`

`tar jxf /vagrant/$1.tar.bz2 -C $SRC_DIR`

`(cd $VERSION_DIR && ./configure --enable-opcache --prefix=/opt/php55 --with-curl=/usr/bin --with-openssl-dir=/usr --with-zlib-dir=/usr --with-xpm-dir=/usr --with-xsl=/usr  --with-mcrypt=/usr  --enable-mbstring --enable-zip --with-pear --with-gettext --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data) > /dev/null`
`(cd $VERSION_DIR && make)  > /dev/null`
`(cd $VERSION_DIR && sudo checkinstall --pkgname=php55 -y -D make install) > /dev/null`

exit 0