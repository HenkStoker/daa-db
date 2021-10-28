-- =============================================================================================================
-- Author		: DAA Project (Isabell Bones & Mark Mestrum)
-- Create date	: 02-07-2021
-- Description	: Procedure voor het laden van de nieuwe/geupdate product data in de Data Mart.
--
-- Parameters:
--				01) @full_load,		indien 1, full load van de tabel in de DM
--									indien 0, incrementeele load van allen de laatst gewijzigde/geupdate data in de DM
--
--
-- Modified By	: 
--
-- Cave: Als Customer Tabellen Structuur (Kolommen) in bron veranderen: wijzig metadata, pas kolommen in SP aan
-- =============================================================================================================

CREATE PROCEDURE [dm].[loadDMCustomer](
		@full_load bit
)
AS
BEGIN
	DECLARE @SP_IsFullLoad bit = 1
	--@sinkTruncate = 1 --wordt meegegeven bij het aanroepen van de sp
	--declare @IsFullLoad bit
	--select @IsFullLoad = s.sinkTruncate
	--from [daa-metadata-db].[sql_dwh_state] s
	--where s.table_name = @tablename -- kan ook hard coded naar metadata dm.Product
--BEGIN TRY
	IF @full_load = @SP_IsFullLoad --1=@IsFullLoad
	BEGIN
--Full load, [stg_adv_works].[Customer] data in [dm].[Customer]
		TRUNCATE TABLE dm.Customer
		INSERT INTO dm.Customer([CustomerID]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[CompanyName]
      ,[SalesPerson]
      ,[EmailAddress]
      ,[Phone]
      --,[PasswordHash] -- SSMS error: Invalid column name 'PasswordHash'.
      --,[PasswordSalt]
      ,[rowguid]
      --,[ModifiedDate]
      --,[Bron]
	  ,[InsertedInDM] -- TO DO data type aanpassen naar datetime2
      	  )
		SELECT 
		[CustomerID]
		,[Title]
        ,[FirstName]
        ,[MiddleName]
        ,[LastName]
        ,[Suffix]
        ,[CompanyName]
        ,[SalesPerson]
        ,[EmailAddress]
        ,[Phone]
        --,[PasswordHash]
        --,[PasswordSalt]
        ,[rowguid]
        --,[ModifiedDate]
        --,[Bron]
		, SYSDATETIME() -- welke data type
		FROM  [stg_adv_works].[Customer]
	END
	ELSE
	 --TO DO error melding, later op focusen
	SELECT ERROR_MESSAGE() AS ErrorMessage


	--EXEC logging.usp_UpdateEtlLog
 --          @DataFactoryName = @p_dataFactoryName,
 --          @PipelineName = @p_pipelineName,
 --          @Source = 'stg.CandidateAnalysis',
 --          @SourceType = 'AzureSqlDatabase',
 --          @Destination = 'dwh.fact_CandidateAnalysis',
 --          @SinkType = 'AzureSqlDatabase',
 --          @RowsRead = 0,
 --          @RowsCopied = @l_rowsCopied,
 --          @RunId = NULL,
 --          @TriggerType = 'Stored Procedure',
 --          @TriggerId = NULL,
 --          @TriggerName = 'dwh.Load_fact_CandidateAnalysis',
 --          @TriggerTime = @p_loadDate,
 --          @ExecutionStatus = 'Succeeded',
 --          @CopyStartTime = @l_executionStartTime,
 --          @CopyEndTime = @l_executionEndTime,
 --          @CopyDurationSecs = @l_copyDuration

--END TRY
END
