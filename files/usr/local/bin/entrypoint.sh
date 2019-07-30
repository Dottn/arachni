#!/bin/bash

PATH_ARACHNI="/usr/local/arachni"
FILE_DB_PGSQL_TEMPLATE="${PATH_ARACHNI}/system/arachni-ui-web/config/database.yml.pgsql"
FILE_DB="${PATH_ARACHNI}/system/arachni-ui-web/config/database.yml"

setupPostgresqlDB()
{
  sed -i 's/host: localhost/host: '${DB_HOST}'/' ${FILE_DB_PGSQL_TEMPLATE}
  sed -i 's/database: arachni_.*$/database: '${DB_NAME}'/' ${FILE_DB_PGSQL_TEMPLATE}
  sed -i 's/username: arachni/username: '${DB_USER}'/' ${FILE_DB_PGSQL_TEMPLATE}
  sed -i 's/password: secret/password: '${DB_PASS}'/' ${FILE_DB_PGSQL_TEMPLATE}
  rm ${FILE_DB}
  mv ${FILE_DB_PGSQL_TEMPLATE} ${FILE_DB}

  ${PATH_ARACHNI}/bin/arachni_web_task db:setup
}

if [ "postgresql" = "${DB_ADAPTER}" ]; then
  setupPostgresqlDB
fi

supervisord -c /etc/supervisor.conf
