CREATE TABLE [dm].[Product] (
    [ProductID]         INT              NOT NULL,
    [Name]              NVARCHAR (150)   NULL,
    [ProductNumber]     NVARCHAR (25)    NOT NULL,
    [Color]             NVARCHAR (15)    NULL,
    [StandardCost]      MONEY            NOT NULL,
    [ListPrice]         MONEY            NOT NULL,
    [ProductCategoryID] INT              NULL,
    [ProductModelID]    INT              NULL,
    [SellStartDate]     DATETIME         NOT NULL,
    [SellEndDate]       DATETIME         NULL,
    [DiscontinuedDate]  DATETIME         NULL,
    [rowguid]           UNIQUEIDENTIFIER NOT NULL,
    [Bron]              NVARCHAR (255)   NULL,
    [InsertedInDM]      DATETIME         NOT NULL,
    [ProdSurrogateID]   INT              IDENTITY (1, 1) NOT NULL,
    [ValidFrom]         DATE             NOT NULL,
    [ValidTo]           DATE             NULL
);

