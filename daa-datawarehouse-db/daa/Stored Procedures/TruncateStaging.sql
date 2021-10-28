
CREATE PROCEDURE [daa].[TruncateStaging]
	(
		  @tableschema nvarchar(100)
		, @tablename nvarchar(100)
	)

AS

BEGIN

--TRUNCATE TABLE [@tableschema].[@tablename]


DECLARE @l_statement nvarchar(MAX)

SET @l_statement = N'IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[' + @tableschema+'].['+@tableName+ ']'') AND type in (N''U''))
			TRUNCATE TABLE [' + @tableschema+'].['+@tableName+ ']'
EXECUTE sp_executesql @l_statement
END
