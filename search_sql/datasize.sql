use isuconp;
SELECT
    table_name,
    engine,
    table_rows,
    avg_row_length,
    floor((data_length+index_length)/1024/1024) as allMB,
    floor((data_length)/1024/1024) as dMB,
    floor((index_length)/1024/1024) as iMB
FROM
    information_schema.tables
WHERE
    table_schema=database()
ORDER BY
    (data_length+index_length) DESC;
