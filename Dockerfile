FROM node:6.10.2-slim


# Working enviroment
ENV APPDIR /var/app/cnpmjs.org
ENV CNPMJS_REPOSITORY zuibunan/cnpmjs.org
ENV CNPMJS_ORG_VERSION 3.0.0-rc.21

RUN \
  mkdir /var/app && \
  install -o www-data -d /var/app && \
  mkdir /var/www && chown www-data:www-data -R /var/www

USER www-data

RUN \
  wget -P /tmp https://github.com/${CNPMJS_REPOSITORY}/archive/${CNPMJS_ORG_VERSION}.tar.gz && \
  tar xvzf /tmp/${CNPMJS_ORG_VERSION}.tar.gz -C /var/app && \
  mv /var/app/cnpmjs.org-${CNPMJS_ORG_VERSION} ${APPDIR}

WORKDIR ${APPDIR}

RUN npm install

EXPOSE 7001 7002

# Entrypoint
CMD ["/usr/local/bin/node", "/var/app/cnpmjs.org/dispatch.js"]
