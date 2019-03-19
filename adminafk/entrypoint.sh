#!/bin/bash

ADMINAFK_WEB_HOME='/var/www/html'

BASE_URL="${BASE_URL:-adminafk}"

MYSQL_HOST="${MYSQL_HOST:-mysql}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_DB="${MYSQL_DB:-adminafk}"
MYSQL_USER="${MYSQL_USER:-adminafk}"
MYSQL_PASS="${MYSQL_PASS:-adminafk}"

EBOT_MYSQL_HOST="${EBOT_MYSQL_HOST:-mysql}"
EBOT_MYSQL_PORT="${EBOT_MYSQL_PORT:-3306}"
EBOT_MYSQL_DB="${EBOT_MYSQL_DB:-ebotv3}"
EBOT_MYSQL_USER="${EBOT_MYSQL_USER:-ebotv3}"
EBOT_MYSQL_PASS="${EBOT_MYSQL_PASS:-ebotv3}"

# for usage with docker-compose
while ! nc -z $MYSQL_HOST $MYSQL_PORT; do sleep 3; done

if [ ! -f .installed ]
then
    # init db if not already initialized
    mysql -u $MYSQL_USER -p$MYSQL_PASS < $ADMINAFK_WEB_HOME/adminafk.sql

    # manage config
    sed -i "s|\$BASE_URL.*|\$BASE_URL = '${BASE_URL}';|" $ADMINAFK_WEB_HOME/config/config.php
    
    sed -i "s|\$SERVERNAME_ADMINAFK.*|\$SERVERNAME_ADMINAFK = '${MYSQL_HOST}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$PORT_ADMINAFK.*|\$PORT_ADMINAFK = '${MYSQL_PORT}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$DBNAME_ADMINAFK.*|\$DBNAME_ADMINAFK = '${MYSQL_DB}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$USERNAME_ADMINAFK.*|\$USERNAME_ADMINAFK = '${MYSQL_USER}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$PASSWORD_ADMINAFK.*|\$PASSWORD_ADMINAFK = '${MYSQL_PASS}';|" $ADMINAFK_WEB_HOME/config/config.php
    
    sed -i "s|\$SERVERNAME_EBOT.*|\$SERVERNAME_EBOT = '${EBOT_MYSQL_HOST}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$PORT_EBOT.*|\$PORT_EBOT = '${EBOT_MYSQL_PORT}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$DBNAME_EBOT.*|\$DBNAME_EBOT = '${EBOT_MYSQL_DB}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$USERNAME_EBOT.*|\$USERNAME_EBOT = '${EBOT_MYSQL_USER}';|" $ADMINAFK_WEB_HOME/config/config.php
    sed -i "s|\$PASSWORD_EBOT.*|\$PASSWORD_EBOT = '${EBOT_MYSQL_PASS}';|" $ADMINAFK_WEB_HOME/config/config.php

    touch .installed
fi

apache2-foreground
