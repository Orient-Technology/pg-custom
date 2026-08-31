FROM timescale/timescaledb-ha:pg18

USER root
RUN sed -i "s/^shared_preload_libraries =.*/shared_preload_libraries = 'timescaledb,pg_cron,pg_stat_statements'/" \
    /usr/share/postgresql/18/postgresql.conf.sample

USER postgres

