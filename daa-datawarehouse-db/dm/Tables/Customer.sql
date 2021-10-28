CREATE TABLE [dm].[Customer] (
    [CustomerID]      INT              NOT NULL,
    [Title]           NVARCHAR (8)     NULL,
    [FirstName]       NVARCHAR (50)    NOT NULL,
    [MiddleName]      NVARCHAR (50)    NULL,
    [LastName]        NVARCHAR (50)    NOT NULL,
    [Suffix]          NVARCHAR (10)    NULL,
    [CompanyName]     NVARCHAR (128)   NULL,
    [SalesPerson]     NVARCHAR (256)   NULL,
    [EmailAddress]    NVARCHAR (50)    NULL,
    [Phone]           NVARCHAR (25)    NULL,
    [rowguid]         UNIQUEIDENTIFIER NOT NULL,
    [InsertedInDM]    DATETIME         NULL,
    [CustSurrogateID] INT              IDENTITY (1, 1) NOT NULL
);

