ARG PG_MAJOR="18"

FROM postgres:${PG_MAJOR}


RUN apt-get update && apt-get install -y \
    postgresql-${PG_MAJOR}-cron \
    postgresql-${PG_MAJOR}-postgis \
    postgresql-${PG_MAJOR}-jsquery \
    postgresql-${PG_MAJOR}-pgvector \
    postgresql-${PG_MAJOR}-timescaledb \
    && rm -rf /var/lib/apt/lists/*

RUN printf "\n\
shared_preload_libraries='timescaledb,pg_cron,pg_stat_statements'\n\
" >> /usr/share/postgresql/postgresql.conf.sample

