ARG PG_MAJOR=18
FROM ghcr.io/cloudnative-pg/postgresql:${PG_MAJOR}-standard-trixie
ARG PG_MAJOR
USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl lsb-release \
 && curl -fsSL https://packagecloud.io/timescale/timescaledb/gpgkey \
      | gpg --dearmor -o /usr/share/keyrings/timescaledb.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/timescaledb.gpg] https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/timescaledb.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      timescaledb-2-postgresql-${PG_MAJOR} \
      postgresql-${PG_MAJOR}-postgis-3 \
      postgresql-${PG_MAJOR}-cron \
 && apt-get purge -y --auto-remove curl lsb-release \
 && rm -rf /var/lib/apt/lists/*

USER 26