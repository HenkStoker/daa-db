CREATE TABLE [stg_adv_works].[SalesOrderDetail] (
    [SalesOrderID]       INT              NOT NULL,
    [SalesOrderDetailID] INT              NOT NULL,
    [OrderQty]           SMALLINT         NOT NULL,
    [ProductID]          INT              NOT NULL,
    [UnitPrice]          MONEY            NOT NULL,
    [UnitPriceDiscount]  MONEY            NOT NULL,
    [LineTotal]          NUMERIC (38, 6)  NOT NULL,
    [rowguid]            UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]       DATETIME         NOT NULL,
    [Bron]               NVARCHAR (255)   NULL,
    [LoadDate]           DATE             NULL,
    [InsertedInDWH]      DATETIME         NULL
);

