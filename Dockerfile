# Set the base image to Ubuntu
FROM couchbase/sync-gateway

# Install tools
RUN yum install -y \
      curl \
      git \
      perl \
      which \
 && yum clean all

# Install Node.js
RUN curl -sL -o ns.rpm https://rpm.nodesource.com/pub/el/7/x86_64/nodejs-0.10.31-1nodesource.el7.centos.x86_64.rpm \
 && rpm -i --nosignature --force ns.rpm \
 && rm -f ns.rpm

RUN npm install -g pangyp\
 && ln -s $(which pangyp) $(dirname $(which pangyp))/node-gyp\
 && npm cache clear\
 && node-gyp configure || echo ""

ENV NODE_ENV production

# Install babel
RUN npm install -g babel

# Provides cached layer for node_modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /src && cp -a /tmp/node_modules /src/

# Define working directory
WORKDIR /src
ADD . /src

RUN chmod +x /src/run.sh

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["/src/run.sh"]

EXPOSE 8000 4984