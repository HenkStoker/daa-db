CREATE EXTERNAL DATA SOURCE [ext_ds_metadata]
    WITH (
    TYPE = RDBMS,
    LOCATION = N'daa-sql-server.database.windows.net',
    DATABASE_NAME = N'daa-metadata-db',
    CREDENTIAL = [mdd_credential]
    );

