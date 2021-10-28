CREATE TABLE [daa].[MetaTableColumns] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [table_id]        INT           NOT NULL,
    [column_name]     NVARCHAR (50) NOT NULL,
    [column_datatype] NVARCHAR (50) NOT NULL,
    [column_order_id] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_TableColumns_Tables] FOREIGN KEY ([table_id]) REFERENCES [daa].[MetaTables] ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_MTC_table_id]
    ON [daa].[MetaTableColumns]([table_id] DESC);

