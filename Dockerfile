FROM postgres:10-beta1

RUN apt-get update && apt-get install -y \
    build-essential \
    postgresql-server-dev-${PG_MAJOR} \
    libphonenumber-dev \
    sudo

COPY ./ /data/
RUN chown -R postgres:postgres /data/

# Patch the entrypoint script so it always initializes the DB.
RUN patch /usr/local/bin/docker-entrypoint.sh < /data/docker-entrypoint.patch

# Build pg_libphonenumber.
WORKDIR /data
RUN make && make install

CMD ["/data/run-tests.sh", "${PG_MAJOR}"]
