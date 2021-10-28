CREATE TABLE [logging].[EtlLog] (
    [MasterPipelineID] NVARCHAR (500) NULL,
    [EtlLogId]         INT            IDENTITY (1, 1) NOT NULL,
    [PipelineName]     NVARCHAR (500) NOT NULL,
    [ComponentName]    NVARCHAR (500) NOT NULL,
    [StartTime]        DATETIME2 (0)  NOT NULL,
    [EndTime]          DATETIME2 (0)  NULL,
    [DurationSeconds]  INT            NULL,
    [Inserts]          INT            NULL,
    [Updates]          INT            NULL,
    [Deletes]          INT            NULL,
    [ErrorMessage]     NVARCHAR (MAX) NULL,
    [InsertUser]       NVARCHAR (100) CONSTRAINT [DF_EtlLog_InsertUser] DEFAULT (original_login()) NOT NULL,
    [InsertTime]       DATETIME2 (0)  CONSTRAINT [DF_EtlLog_InsertTime] DEFAULT (sysdatetime()) NOT NULL,
    [LastUpdateUser]   NVARCHAR (100) NULL,
    [LastUpdateTime]   DATETIME2 (0)  NULL
);

