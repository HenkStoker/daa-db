CREATE TABLE [daa].[Product] (
    [ID]            INT            IDENTITY (1, 1) NOT NULL,
    [DAA_col_1]     INT            NULL,
    [DAA_col_2]     NVARCHAR (100) NULL,
    [DAA_col_3]     NVARCHAR (50)  NULL,
    [Date_Created]  DATETIME2 (7)  NULL,
    [Date_Modified] DATETIME2 (7)  NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ID] ASC)
);

