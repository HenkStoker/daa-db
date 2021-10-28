CREATE EXTERNAL TABLE [daa].[MetaTables] (
    [Id] INT NOT NULL,
    [table_name] NVARCHAR (50) NOT NULL,
    [table_schema] NVARCHAR (50) NOT NULL,
    [recreate] INT NULL,
    [type] NVARCHAR (50) NULL
)
    WITH (
    DATA_SOURCE = [ext_ds_metadata]
    );

