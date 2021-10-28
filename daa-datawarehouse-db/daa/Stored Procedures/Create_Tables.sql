



-- =============================================================================================================
-- Author		: DAA Project (Rene van Elmpt)
-- Create date	: 28-04-2021
-- Description	: Procedure voor het aanmaken van de tabellen op basis van de Metadata.
--
-- parameters:
--				01) @execute,		indien 1 dan direct uitvoeren anders SQL in select statement.
--				02) @tableName,		indien NULL dan alle tabellen.
--
--
-- Modified By	: 
--
-- =============================================================================================================
CREATE   PROCEDURE [daa].[Create_Tables]
(
	@execute	BIT = 0,
	@tableName	NVARCHAR(100) = NULL
)

AS

BEGIN

	SET NOCOUNT ON

	DECLARE @sql				nvarchar(4000);
	DECLARE @tabellen			table(rownum int
									, table_id int
									, table_name nvarchar(50)
									, table_schema nvarchar(50)
									, recreate int);

	DECLARE @businessKeyArray	table(id int, fieldName nvarchar(100));
	DECLARE @sourceTableName	nvarchar(100);
	DECLARE @schemaName			nvarchar(50);
	DECLARE @tableId			int;
	DECLARE @recreate			int;
	DECLARE @databaseName		nvarchar(50);

	DECLARE @cnt_1				int = 1;
	DECLARE @cnt_2				int = 1;
    DECLARE @velden				nvarchar(4000);
	-- ---------------------------------------------------------------------------------------------------------
	-- Indien er geen tabel als parameter wordt meegegeven zal deze procedure alle tabellen aanmaken
	-- ---------------------------------------------------------------------------------------------------------
	INSERT INTO @tabellen		
		SELECT ROW_NUMBER() OVER(ORDER BY table_name) rownum
				,[id]
				,[table_name]
				,[table_schema]
				,[recreate]
		FROM [daa].[MetaTables]
		WHERE (table_name = @tableName OR @tableName IS NULL)

	-- Verwerk de tabel(len)
	WHILE (@cnt_1 <= (SELECT MAX(rownum) FROM @tabellen))
	BEGIN
 		SET @tableName		= (SELECT TOP(1) table_name FROM @tabellen WHERE rownum = @cnt_1)
		SET @schemaName		= (SELECT TOP(1) table_schema FROM @tabellen WHERE rownum = @cnt_1) 
		SET @tableId		= (SELECT TOP(1) table_id FROM @tabellen WHERE rownum = @cnt_1) 
		SET @recreate		= (SELECT TOP(1) recreate FROM @tabellen WHERE rownum = @cnt_1) 
		PRINT '==========================================================='
		PRINT 'Verwerk tabel [' + @tableName + '] ...'
		PRINT '==========================================================='

        -- als voor de betreffende tabel de recreate vlag aan staat, dan wordt de tabel gedropt als deze bestaat
        IF @recreate = 1
        BEGIN
 		    SET @sql =	'
			    		IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[' + @schemaName + '].[' + @tableName + ']'') AND type in (N''U''))
				    	DROP TABLE [' + @schemaName + '].[' + @tableName + ']'
		    IF (@execute = 1) EXEC sp_executesql @sql; ELSE SELECT @sql AS SqlStatement
        END

        -- haal de velden op voor de betreffende tabel
		SET @velden = null
		SELECT @velden = COALESCE (@velden + ', ', '') + fieldName
		FROM 
		(
			SELECT '[DAA_' + column_name + '] ' + column_datatype as fieldName
			FROM daa.MetaTableColumns
			WHERE table_id = @tableId
			ORDER BY column_order_id
			OFFSET 0 ROWS
		)A
		--select @velden

		SET @sql =	'
					IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[' + @schemaName + '].[' + @tableName + ']'') AND type in (N''U''))
					CREATE TABLE [' + @schemaName + '].[' + @tableName + '](
						[ID] [int] IDENTITY(1,1) NOT NULL,
						' + @velden + ',
						[Date_Created] [datetime2],
						[Date_Modified] [datetime2],
					CONSTRAINT [PK_' + @tableName + '] PRIMARY KEY ([ID])
					)'
		IF (@execute = 1) EXEC sp_executesql @sql; ELSE SELECT @sql AS SqlStatement
		PRINT 'Tabel verwerkt'



		SET @cnt_1+= 1;
	END
END




