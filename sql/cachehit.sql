SELECT
    (
        SELECT
            VARIABLE_VALUE
        FROM
            INFORMATION_SCHEMA.GLOBAL_STATUS
        WHERE
            VARIABLE_NAME = 'QCACHE_HITS')/(
                SELECT
                    SUM(VARIABLE_VALUE)
                FROM
                    INFORMATION_SCHEMA.GLOBAL_STATUS
                WHERE
                    VARIABLE_NAME
                IN
                    ('QCACHE_HITS','QCACHE_INSERTS','QCACHE_NOT_CACHED')
            )*100 AS CACHE_HIT_RATE;
