#!/bin/bash

sed -ie s/THE_SITE_DIR/$SITE_DIR/g /etc/apache2/apache2.conf
/usr/sbin/apache2ctl -D FOREGROUND

