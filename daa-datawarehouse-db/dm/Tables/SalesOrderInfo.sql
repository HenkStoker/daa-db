CREATE TABLE [dm].[SalesOrderInfo] (
    [SalesOrderID]        INT             NOT NULL,
    [SalesOrderDetailID]  INT             NOT NULL,
    [SalesOrderNumber]    NVARCHAR (25)   NOT NULL,
    [PurchaseOrderNumber] NVARCHAR (25)   NULL,
    [ProductID]           INT             NOT NULL,
    [OrderQty]            SMALLINT        NOT NULL,
    [UnitPrice]           MONEY           NOT NULL,
    [UnitPriceDiscount]   MONEY           NOT NULL,
    [LineTotal]           NUMERIC (38, 6) NOT NULL,
    [AccountNumber]       NVARCHAR (15)   NULL,
    [CustomerID]          INT             NOT NULL,
    [ShipToAddressID]     INT             NULL,
    [BillToAddressID]     INT             NULL,
    [OrderDate]           DATETIME        NOT NULL,
    [DueDate]             DATETIME        NOT NULL,
    [ShipDate]            DATETIME        NULL,
    [InsertedInDM]        DATETIME        NULL
);

