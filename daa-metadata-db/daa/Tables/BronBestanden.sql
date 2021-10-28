CREATE TABLE [daa].[BronBestanden] (
    [objectID]              INT            NOT NULL,
    [objectName]            NVARCHAR (100) NULL,
    [sourceType]            NVARCHAR (100) NULL,
    [sourceSchema]          NVARCHAR (100) NULL,
    [sourceTable]           NVARCHAR (100) NULL,
    [sourceFolder]          NVARCHAR (100) NULL,
    [sourceFile]            NVARCHAR (100) NULL,
    [DL_stg_folder]         NVARCHAR (100) NULL,
    [DL_stg_file]           NVARCHAR (100) NULL,
    [sinkSchema_stg_dwh]    NVARCHAR (100) NULL,
    [sinkTable_stg_dwh]     NVARCHAR (100) NULL,
    [sinkTruncate]          BIT            NULL,
    [sourceActive]          BIT            NULL,
    [lastLoadDate]          SMALLDATETIME  NULL,
    [rebuildDM]             BIT            CONSTRAINT [DF__BronBesta__rebui__5DEAEAF5] DEFAULT ((0)) NULL,
    [incrementalLoad]       BIT            NULL,
    [incrementalLoadColumn] NVARCHAR (100) NULL,
    CONSTRAINT [PK_BronBestanden] PRIMARY KEY CLUSTERED ([objectID] ASC)
);

