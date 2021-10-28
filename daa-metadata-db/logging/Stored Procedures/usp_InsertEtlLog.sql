
--=================================================================================
--Created by:  Chris Jenkins
--Date:        3rd May 2020
--Description: Inserts a new ETL log record.
--Usage:       EXEC logging.usp_InsertEtlLog @PipelineName  = 'Test Pipeline'
--                                         , @ComponentName = 'Test Component'
--                                         , @StartTime     = '2020-05-03 09:00:00';
--=================================================================================
CREATE   PROCEDURE [logging].[usp_InsertEtlLog]
    @MasterPipelineID	NVARCHAR(500)
  , @PipelineName		VARCHAR(500)
  , @ComponentName		NVARCHAR(500)
  , @StartTime			DATETIME2(0)
  , @EndTime			DATETIME2(0) = NULL
  , @DurationSeconds	INT = NULL
  , @Inserts			INT = NULL
  , @Updates			INT = NULL
  , @Deletes			INT = NULL
  , @ErrorMessage		NVARCHAR(500) = NULL
AS
SET NOCOUNT ON;

DECLARE @l_StartTime DATETIME2(0) = SYSDATETIMEOFFSET() AT TIME ZONE 'W. Europe Standard Time'

INSERT INTO logging.EtlLog
   (MasterPipelineID
  , PipelineName
  , ComponentName
  , StartTime
  , EndTime
  , DurationSeconds
  , Inserts
  , Updates
  , Deletes
  , ErrorMessage)
VALUES (@MasterPipelineID
	  , @PipelineName
      , @ComponentName
      , @l_StartTime
      , @EndTime
      , @DurationSeconds
      , @Inserts
      , @Updates
      , @Deletes
      , @ErrorMessage);

SELECT SCOPE_IDENTITY() AS EtlLogId;
