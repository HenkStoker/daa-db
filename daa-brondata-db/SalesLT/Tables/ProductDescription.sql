CREATE TABLE [SalesLT].[ProductDescription] (
    [ProductDescriptionID] INT              NOT NULL,
    [Description]          NVARCHAR (400)   NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]         DATETIME         NOT NULL
);

