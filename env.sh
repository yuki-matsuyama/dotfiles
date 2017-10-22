#一番最初に修正

export NGINX_ACCESS_LOG=/var/log/nginx/access.log
export MYSQL_SLOW_LOG=/tmp/mysql-slow.log
export TOOLS_DIR=/home/isucon/isucon_tools
export APP_LOG=

## deployのために使用する変数

export IPADDR=isucon7
export USERNAME=isucon

## databaseの操作に関する変数

export DB_PASS=isucon
export DB_USER=isucon
export DB_NAME=isuda

# optionnaly errorログの場所を見る

export NGINX_ERROR_LOG=/var/log/nginx/error.log
export MYSQL_ERROR_LOG=/var/log/mysql/error.log
