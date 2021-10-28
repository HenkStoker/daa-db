
--=================================================================================
--Created by:  Chris Jenkins
--Date:        3rd May 2020
--Description: Updates an existing ETL log record.
--Usage:       EXEC logging.usp_UpdateEtlLog @EtlLogId        = 1
--                                         , @EndTime         = '2020-05-03 09:01:00'
--                                         , @DurationSeconds = 60
--                                         , @Inserts         = 100;
--=================================================================================
CREATE   PROCEDURE [logging].[usp_UpdateEtlLog]
    @EtlLogId        INT
  , @EndTime         DATETIME2(0)
  , @DurationSeconds INT = NULL
  , @Inserts         INT = NULL
  , @Updates         INT = NULL
  , @Deletes         INT = NULL
  , @ErrorMessage    NVARCHAR(500) = NULL
AS
SET NOCOUNT ON;

DECLARE @l_EndTime DATETIME2(0) = SYSDATETIMEOFFSET() AT TIME ZONE 'W. Europe Standard Time'

-- If we don't have the duration calculate it
IF (@DurationSeconds IS NULL)
BEGIN
    SELECT @DurationSeconds = DATEDIFF(SS, StartTime, @l_EndTime)
    FROM   logging.EtlLog
    WHERE  EtlLogId = @EtlLogId;
END

UPDATE logging.EtlLog
SET    EndTime = @EndTime
     , DurationSeconds = @DurationSeconds
     , Inserts = @Inserts
     , Updates = @Updates
     , Deletes = @Deletes
     , ErrorMessage = @ErrorMessage
     , LastUpdateUser = ORIGINAL_LOGIN()
     , LastUpdateTime = SYSDATETIMEOFFSET() AT TIME ZONE 'W. Europe Standard Time'
WHERE  EtlLogId = @EtlLogId;
