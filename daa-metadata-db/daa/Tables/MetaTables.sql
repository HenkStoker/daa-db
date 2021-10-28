CREATE TABLE [daa].[MetaTables] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [table_name]   NVARCHAR (50) NOT NULL,
    [table_schema] NVARCHAR (50) NOT NULL,
    [recreate]     INT           NULL,
    [type]         NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

