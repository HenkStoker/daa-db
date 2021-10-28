CREATE EXTERNAL TABLE [daa].[MetaTableColumns] (
    [Id] INT NOT NULL,
    [table_id] INT NOT NULL,
    [column_name] NVARCHAR (50) NOT NULL,
    [column_datatype] NVARCHAR (50) NOT NULL,
    [column_order_id] INT NOT NULL
)
    WITH (
    DATA_SOURCE = [ext_ds_metadata]
    );

