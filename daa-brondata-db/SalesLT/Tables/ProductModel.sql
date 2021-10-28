CREATE TABLE [SalesLT].[ProductModel] (
    [ProductModelID]     INT              NOT NULL,
    [Name]               NVARCHAR (50)    NOT NULL,
    [CatalogDescription] XML              NULL,
    [rowguid]            UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]       DATETIME         NOT NULL
);

