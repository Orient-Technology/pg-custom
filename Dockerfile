ARG PG_MAJOR=18
FROM postgres:${PG_MAJOR}-trixie
ARG PG_MAJOR

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl gnupg lsb-release \
 && curl -fsSL https://packagecloud.io/timescale/timescaledb/gpgkey \
      | gpg --dearmor -o /usr/share/keyrings/timescaledb.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/timescaledb.gpg] https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -cs) main" \
      > /etc/apt/sources.list.d/timescaledb.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      timescaledb-2-postgresql-${PG_MAJOR} \
      postgresql-${PG_MAJOR}-postgis-3 \
      postgresql-${PG_MAJOR}-pgvector \
      postgresql-${PG_MAJOR}-cron \
 && apt-get purge -y --auto-remove curl gnupg lsb-release \
 && rm -rf /var/lib/apt/lists/*
