CREATE TABLE [daa].[Customer] (
    [ID]            INT           IDENTITY (1, 1) NOT NULL,
    [DAA_col_1]     NVARCHAR (10) NULL,
    [DAA_col_2]     NVARCHAR (20) NULL,
    [DAA_col_3]     DATETIME2 (7) NULL,
    [Date_Created]  DATETIME2 (7) NULL,
    [Date_Modified] DATETIME2 (7) NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([ID] ASC)
);

