FROM tutum/apache-php
MAINTAINER Pavel Litvinenko <gerasim13@gmail.com>

ENV MODX 2.1.5
ADD https://modx.s3.amazonaws.com/releases/${MODX}/modx-${MODX}-pl.zip /tmp/${MODX}.zip

RUN apt-get update && apt-get install zip unzip && \
    unzip /tmp/${MODX}.zip -d /tmp && \
    rm -rf /app/* && \
    cp -r /tmp/modx-${MODX}/* /app && \
    rm -rf /tmp/*

VOLUME /app/assets
VOLUME /app/core/packages
VOLUME /app/core/cache
VOLUME /app/core/import
VOLUME /app/core/export

RUN touch /app/core/config/config.inc.php && \
    chmod -R 777 /app/core/config && \
    chmod -R 777 /app/core/packages && \
    chmod -R 777 /app/core/cache && \
    chmod -R 777 /app/core/import && \
    chmod -R 777 /app/core/export && \
    chmod -R 777 /app/assets && \
    chmod 701 /app/core/xpdo/compression/xpdozip.class.php && \
    chmod 644 /app/core/config/config.inc.php && \
    chmod 644 /app/core/packages/core/manifest.php

RUN mv /app/ht.access /app/.htaccess && \
    mv /app/manager/ht.access /app/manager/.htaccess && \
    mv /app/core/ht.access /app/core/.htaccess

# ENV MYSQL_SERVER_TYPE myslq
# ENV MYSQL_SERVER_HOST localhost
# ENV MYSQL_USER db_username
# ENV MYSQL_PASSWORD db_password
# ENV ADMIN_LOGIN admin
# ENV ADMIN_PASSWORD password
# ENV ADMIN_EMAIL email@address.com
# ENV CTX_WEB_PATH /app/
# ENV CTX_WEB_URL /
# ENV CTX_MGR_PATH ${CTX_WEB_PATH}manager/
# ENV CTX_MGR_URL ${CTX_WEB_URL}manager/
# ENV CTX_CONNECTORS_PATH ${CTX_WEB_PATH}connectors/
# ENV CTX_CONNECTORS_URL ${CTX_WEB_URL}connectors/
# ENV CORE_PATH ${CTX_WEB_PATH}core/

# ONBUILD RUN cp /app/setup/config.dist.new.xml /app/setup/config.xml && \
#     # Mysql settings
#     sed -i 's#\(<database_type>\)[0-9a-z.\/]*\(</database_type>\)#\1'${MYSQL_SERVER_TYPE}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<database_server>\)[0-9a-z.\/]*\(</database_server>\)#\1'${MYSQL_SERVER_HOST}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<database_user>\)[0-9a-z.\/]*\(</database_user>\)#\1'${MYSQL_USER}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<database_password>\)[0-9a-z.\/]*\(</database_password>\)#\1'${MYSQL_PASSWORD}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<database_type>\)[0-9a-z.\/]*\(</database_type>\)#\1'${MYSQL_SERVER_TYPE}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<database_type>\)[0-9a-z.\/]*\(</database_type>\)#\1'${MYSQL_SERVER_TYPE}'\2#g' /app/setup/config.xml && \
#     # Context
#     sed -i 's#\(<context_mgr_path>\)[0-9a-z.\/]*\(</context_mgr_path>\)#\1'${CTX_MGR_PATH}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<context_mgr_url>\)[0-9a-z.\/]*\(</context_mgr_url>\)#\1'${CTX_MGR_URL}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<context_connectors_path>\)[0-9a-z.\/]*\(</context_connectors_path>\)#\1'${CTX_CONNECTORS_PATH}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<context_connectors_url>\)[0-9a-z.\/]*\(</context_connectors_url>\)#\1'${CTX_CONNECTORS_URL}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<context_web_path>\)[0-9a-z.\/]*\(</context_web_path>\)#\1'${CTX_WEB_PATH}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<context_web_url>\)[0-9a-z.\/]*\(</context_web_url>\)#\1'${CTX_WEB_URL}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<core_path>\)[0-9a-z.\/]*\(</core_path>\)#\1'${CORE_PATH}'\2#g' /app/setup/config.xml && \
#     # Admin account
#     sed -i 's#\(<cmsadmin>\)[0-9a-z.\/]*\(</cmsadmin>\)#\1'${ADMIN_LOGIN}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<cmspassword>\)[0-9a-z.\/]*\(</cmspassword>\)#\1'${ADMIN_PASSWORD}'\2#g' /app/setup/config.xml && \
#     sed -i 's#\(<cmsadminemail>\)[0-9a-z.\/]*\(</cmsadminemail>\)#\1'${ADMIN_EMAIL}'\2#g' /app/setup/config.xml
#
# ONBUILD RUN php /app/index.php --installmode=new --core_path=${CORE_PATH} && \
#     rm -rf /app/setup && \
#     rm -rf /app/_build
