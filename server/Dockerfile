FROM couchbase/server

RUN mkdir -p /src

WORKDIR /src/
ADD . /src/

RUN chmod +x /src/run.sh

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["/src/run.sh"]

EXPOSE 8091