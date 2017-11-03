#!/bin/bash
set -ex

if [ -f $MYSQL_SLOW_LOG ]; then
    sudo mv $MYSQL_SLOW_LOG $MYSQL_SLOW_LOG.$(date "+%Y%m%d_%H%M%S")
fi
if [ -f $NGINX_ACCESS_LOG ]; then
    sudo mv $NGINX_ACCESS_LOG $NGINX_ACCESS_LOG.$(date "+%Y%m%d_%H%M%S")
fi
